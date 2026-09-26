// hando: camera hand tracking in jweb (MediaPipe HandLandmarker, tasks-vision 1.0.1).
// Tracks one hand, smooths it (One Euro filter), maps it to 0..1 (X, Y through a fixed box; Z between
// calibrated near and far marks) and draws the feedback view: mirrored camera, skeleton, box with a
// volt grid, cursor, Z bar, pointing state.
//
// Controls (all 0..1), live only while you point (index finger out, middle, ring and pinky curled):
//   X      index fingertip, left 0 → right 1 (as seen in the mirrored view)
//   Y      index fingertip, bottom 0 → top 1
//   Z      distance from apparent palm size (mean of four palm segments): far 0 → near 1, log scale
//          between the far and near marks. Tilting the palm also shrinks it, so some tilt leaks into Z.
// Any other hand shape (a fist, an open hand) or no hand freezes X, Y and Z at their last live values.
//
// Outlet messages (to Max):
//   cv <x> <y> <z>                  every frame while pointing, and once on freezing (the held values)
//   gate 0|1                        1 while pointing
//   raw <x> <y> <size> <index> <middle> <ring> <pinky> <handedness>
//                                   unfiltered: fingertip x, y 0..1 of the frame (mirrored, y down),
//                                   size = palm size / frame height (unfiltered), then per finger its
//                                   straightness in 3D: 1 = straight, 0 = bent 90°, -1 = curled back
//   calib <near> <far>              after a near / far calibration (log palm size): the patch stores
//                                   it and sends it back when the page is ready
//   stats <fps> <inferMs> <latencyMs> <uptimeS> <source 0 none, 1 local> <loop>
//                                   once a second; latencyMs = camera capture to outlet, -1 if unknown
//   status <text...> / error <text...> / devices <label...> / source local / video <w> <h> <label...>
//   caps <maxW> <maxH> <maxFps>     what the open camera can do
//   blocked <directive> <url>       a network request that the Content-Security-Policy stopped
// Inlet messages (from Max):
//   enable 0|1              1: open the camera, load the model, track. 0: stop, release the camera and
//                           free the model (gate 0, values hold). The page starts off and says
//                           "status start"; the patch answers with its on/off state.
//   calibrate near|far      point and hold still at that distance for 1 s
//   calib <near> <far>      set the Z calibration (from pattr; an older stored list of six numbers,
//                           x0 x1 y0 y1 near far, is also taken, using only its last two)
//   margin <0..0.3>         shrink the X/Y box by this fraction on each side (default 0.05),
//                           so the edges are easy to reach
//   filter <minCutoffHz> <beta>   One Euro filter: lower minCutoff = steadier when still,
//                           higher beta = less lag when moving (defaults 3, 12), for X and Y
//   zfilter <minCutoffHz> <beta>  the same for Z (defaults 0.8, 3)
//   straight <-1..1>        a finger counts as straight above this straightness (default 0.6,
//                           about 53° of bend in total)
//   debounce <frames>       frames a new hand shape must last before it counts (default 2)
//   camera <label...>       pick a camera by (part of) its label
//   devices                 list cameras
//   res <w> <h> [fps]       reopen the camera at this size (and frame rate, default 30)
//   loop rvfc|raf|timer     the tracking loop
//   mirror 0|1              mirror the view (default 1)
//   video 0|1               draw the camera image (default 1)

// Everything is inside one function: the tasks-vision bundle is a classic script too, and
// its top-level names (var C, ...) would clash with ours.
(() => {
"use strict";

const VERSION = "1.0.1";
const LOCAL_WASM = "vendor/tasks-vision@" + VERSION + "/wasm";
const LOCAL_MODEL = "models/hand_landmarker.task";

const { FilesetResolver, HandLandmarker } = exports;

const hasMax = typeof window.max !== "undefined";
function out(...args) {
  if (hasMax) window.max.outlet(...args);
  else console.log(args.join(" "));
}
function bind(name, fn) {
  if (hasMax) window.max.bindInlet(name, fn);
}

const video = document.getElementById("video");
const canvas = document.getElementById("view");
const ctx = canvas.getContext("2d");

let landmarker = null;
let stream = null;
let wantLabel = "MacBook"; // default camera
let wantW = 1280, wantH = 960, wantFps = 30; // 4:3 like 640x480, so the framing and Z match // the MacBook Pro camera's maximum (caps: 30 fps)
let loopMode = "rvfc";
let loopId = 0; // bumps when the loop is restarted, so old loops stop
let mirror = true;
let showVideo = true;
let source = 0; // 0 none, 1 local

let lastVideoTime = -1;
let frames = 0, inferSum = 0, latSum = 0, latN = 0;
const t0 = performance.now();

// ---------- One Euro filter ----------

class OneEuro {
  constructor(params) { this.params = params; this.reset(); }
  reset() { this.x = null; this.dx = 0; this.t = 0; }
  static alpha(cutoff, dt) {
    const tau = 1 / (2 * Math.PI * cutoff);
    return 1 / (1 + tau / dt);
  }
  filter(v, t) {
    if (this.x === null) { this.x = v; this.t = t; return v; }
    const dt = Math.max(t - this.t, 1e-3);
    this.t = t;
    const dv = (v - this.x) / dt;
    this.dx += OneEuro.alpha(1, dt) * (dv - this.dx);
    const cutoff = this.params.minCutoff + this.params.beta * Math.abs(this.dx);
    this.x += OneEuro.alpha(cutoff, dt) * (v - this.x);
    return this.x;
  }
}
const filt = { minCutoff: 3, beta: 12 }; // X, Y: light, so fast moves aren't left behind
const zfilt = { minCutoff: 0.8, beta: 3 }; // Z: palm size is noisier, so smoothed harder
const fx = new OneEuro(filt), fy = new OneEuro(filt), fz = new OneEuro(zfilt);

// ---------- mapping and Z calibration ----------

// X/Y box in frame 0..1 (mirrored, y down), fixed; near / far as log palm size, calibrated
const cal = { x0: 0.15, x1: 0.85, y0: 0.15, y1: 0.85, near: Math.log(0.18), far: Math.log(0.09) };
// near: palm size (mean segment / frame height) at 10 V, the closest the whole hand still fits in
// the frame at the MacBook camera's default zoom; far: about twice as far away
let margin = 0.05;
let calibrating = null; // { what, until, samples: [] }
const Z_SECONDS = 1;

const clamp01 = (v) => Math.min(1, Math.max(0, v));

function box() {
  const mx = (cal.x1 - cal.x0) * margin, my = (cal.y1 - cal.y0) * margin;
  return { x0: cal.x0 + mx, x1: cal.x1 - mx, y0: cal.y0 + my, y1: cal.y1 - my };
}

function map(f) {
  const b = box();
  const ux = (f.x - b.x0) / (b.x1 - b.x0);
  const uy = (b.y1 - f.y) / (b.y1 - b.y0);
  const uz = (f.z - cal.far) / (cal.near - cal.far);
  return {
    x: clamp01(ux), y: clamp01(uy), z: clamp01(uz),
    edgeX: ux < 0 || ux > 1, edgeY: uy < 0 || uy > 1, edgeZ: uz < 0 || uz > 1,
  };
}

function percentile(arr, q) {
  const s = [...arr].sort((a, b) => a - b);
  return s[Math.min(s.length - 1, Math.max(0, Math.round(q * (s.length - 1))))];
}

function sendCalib() {
  out("calib", cal.near, cal.far);
}

function startCalibration(what) {
  calibrating = { what, start: performance.now(), until: performance.now() + Z_SECONDS * 1000, samples: [] };
  out("status", "calibrating", what);
}

function collect(f) {
  if (!calibrating) return;
  calibrating.samples.push(f);
  if (performance.now() < calibrating.until) return;
  const { what, samples } = calibrating;
  calibrating = null;
  if (samples.length < 10) { out("error", "calibration", what, "saw too little of the hand; try again"); return; }
  cal[what] = percentile(samples.map((s) => s.z), 0.5);
  if (Math.abs(cal.near - cal.far) < 0.05) out("error", "calibration: near and far are almost the same");
  out("status", "calibrated", what);
  sendCalib();
}

// ---------- loading ----------

async function createLandmarker(wasmPath, modelPath) {
  const fileset = await FilesetResolver.forVisionTasks(wasmPath);
  return HandLandmarker.createFromOptions(fileset, {
    baseOptions: { modelAssetPath: modelPath, delegate: "GPU" },
    runningMode: "VIDEO",
    numHands: 1,
    minHandDetectionConfidence: 0.5,
    // lower than the 0.5 defaults, so a blurred hand in a fast move stays tracked
    // instead of dropping out and waiting for the palm detector to find it again
    minHandPresenceConfidence: 0.3,
    minTrackingConfidence: 0.3,
  });
}

// Everything loads from this folder. hando.html's Content-Security-Policy blocks all network
// requests, so there is no online fallback, and MediaPipe's usage metrics can't be sent.
async function loadModel() {
  try {
    out("status", "loading model");
    landmarker = await createLandmarker(LOCAL_WASM, LOCAL_MODEL);
    out("source", "local");
    source = 1;
  } catch (e) {
    out("error", "model load failed:", String(e && e.message || e));
  }
}

// report requests the Content-Security-Policy blocked (e.g. MediaPipe's metrics, every 60 s)
document.addEventListener("securitypolicyviolation", (e) => {
  out("blocked", e.violatedDirective, String(e.blockedURI)); // not "status": the patch prints this
});

// ---------- camera ----------

async function listCameras() {
  const devs = (await navigator.mediaDevices.enumerateDevices()).filter((d) => d.kind === "videoinput");
  out("devices", ...devs.map((d) => d.label || d.deviceId));
  return devs;
}

async function openCamera() {
  if (stream) stream.getTracks().forEach((t) => t.stop());
  let devs = await listCameras();
  let dev = devs.find((d) => d.label.toLowerCase().includes(wantLabel.toLowerCase()));
  // ask for wantFps as a minimum; if the camera can't, fall back to its best rate and say so
  const constraints = { width: { ideal: wantW }, height: { ideal: wantH }, aspectRatio: { ideal: wantW / wantH },
    frameRate: { ideal: wantFps, min: wantFps } };
  if (dev) constraints.deviceId = { exact: dev.deviceId };
  try {
    stream = await navigator.mediaDevices.getUserMedia({ video: constraints, audio: false });
  } catch (e) {
    out("error", "camera can't do", wantW, wantH, "at", wantFps, "fps:", e.name, String(e.message || e.constraint || ""));
    constraints.frameRate = { ideal: wantFps };
    try {
      stream = await navigator.mediaDevices.getUserMedia({ video: constraints, audio: false });
    } catch (e2) {
      out("error", "camera failed:", e2.name, String(e2.message));
      return;
    }
  }
  // labels are empty until permission is granted: list again and retry the pick once
  if (!dev) {
    devs = await listCameras();
    const again = devs.find((d) => d.label.toLowerCase().includes(wantLabel.toLowerCase()));
    if (again) return openCamera();
  }
  video.srcObject = stream;
  await video.play();
  const track = stream.getVideoTracks()[0];
  const s = track.getSettings();
  canvas.width = s.width || video.videoWidth;
  canvas.height = s.height || video.videoHeight;
  out("video", canvas.width, canvas.height, track.label, "fps", s.frameRate || 0);
  // what the camera can do: max width, height and frame rate
  const c = track.getCapabilities ? track.getCapabilities() : {};
  out("caps", c.width ? c.width.max : 0, c.height ? c.height.max : 0, c.frameRate ? c.frameRate.max : 0);
}

// ---------- tracking ----------

let present = false; // a hand is seen
let pointing = false; // the pointing shape, after debounce: X, Y, Z are live
let pending = 0; // frames the other shape has lasted
let straightAt = 0.6, debounce = 2;
let held = { x: 0.5, y: 0.5, z: 0.5, edgeX: false, edgeY: false, edgeZ: false }; // the values sent last
let last = null; // { lm, straight } of the latest frame with a hand, for drawing

function dist(a, b, aspect) {
  return Math.hypot((a.x - b.x) * aspect, a.y - b.y);
}

// Finger straightness from MediaPipe's 3D hand (worldLandmarks, in metres), so it works whichever
// way the finger points, including straight at the camera: the cosine between the finger's first
// segment (knuckle to middle joint) and its last (last joint to tip). 1 = straight, -1 = curled back.
// Index, middle, ring, pinky as [knuckle, middle joint, last joint, tip].
const FINGERS = [[5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16], [17, 18, 19, 20]];

function straightness(w, [k, j, d, t]) {
  const ax = w[j].x - w[k].x, ay = w[j].y - w[k].y, az = w[j].z - w[k].z;
  const bx = w[t].x - w[d].x, by = w[t].y - w[d].y, bz = w[t].z - w[d].z;
  const n = Math.hypot(ax, ay, az) * Math.hypot(bx, by, bz);
  return n > 0 ? (ax * bx + ay * by + az * bz) / n : 0;
}

function setPointing(on, now) {
  if (on === pointing) return;
  pointing = on;
  pending = 0;
  if (!on) out("cv", held.x, held.y, held.z); // the last live values stay
  out("gate", on ? 1 : 0);
}

function track(captureTime) {
  if (!landmarker || video.readyState < 2) return;
  if (video.currentTime === lastVideoTime) return;
  lastVideoTime = video.currentTime;

  const t1 = performance.now();
  const res = landmarker.detectForVideo(video, t1);
  const t2 = performance.now();
  frames++;
  inferSum += t2 - t1;

  if (res.landmarks && res.landmarks.length) {
    const aspect = canvas.width / canvas.height;
    // landmarks in the mirrored view
    const lm = res.landmarks[0].map((p) => ({ x: mirror ? 1 - p.x : p.x, y: p.y }));
    // palm size: the mean of four palm segments (wrist to index, middle and pinky knuckles,
    // index to pinky knuckle); a mean is steadier than the largest one, which can switch
    const size = (dist(lm[0], lm[5], aspect) + dist(lm[0], lm[9], aspect) + dist(lm[0], lm[17], aspect) +
      dist(lm[5], lm[17], aspect)) / 4;
    // 3D hand if MediaPipe gave one, else the image landmarks (z there is relative depth)
    const world = res.worldLandmarks && res.worldLandmarks[0] && res.worldLandmarks[0].length === 21
      ? res.worldLandmarks[0] : res.landmarks[0];
    const ratios = FINGERS.map((f) => straightness(world, f));
    const straight = ratios.map((r) => r > straightAt);
    const isPoint = straight[0] && !straight[1] && !straight[2] && !straight[3];
    const h = res.handedness && res.handedness[0] && res.handedness[0][0];

    if (!present) { present = true; fx.reset(); fy.reset(); fz.reset(); }
    const ts = t1 / 1000;
    const f = { x: fx.filter(lm[8].x, ts), y: fy.filter(lm[8].y, ts), z: fz.filter(Math.log(size), ts) };

    if (isPoint !== pointing) {
      if (++pending >= debounce) setPointing(isPoint, t1);
    } else pending = 0;

    if (pointing) {
      const m = map(f);
      held = m;
      out("cv", m.x, m.y, m.z);
      collect(f);
    }
    out("raw", lm[8].x, lm[8].y, size, ...ratios.map((r) => +r.toFixed(3)), h ? h.categoryName : "?");
    last = { lm, straight };
  } else if (present) {
    present = false;
    setPointing(false, t1);
  }
  if (captureTime) { latSum += performance.now() - captureTime; latN++; }
  draw();
}

// ---------- drawing ----------

const BONES = [[0,1],[1,2],[2,3],[3,4],[0,5],[5,6],[6,7],[7,8],[5,9],[9,10],[10,11],[11,12],
  [9,13],[13,14],[14,15],[15,16],[13,17],[17,18],[18,19],[19,20],[0,17]];
const C = { box: "rgba(255,255,255,0.55)", bone: "#7fd", idle: "rgba(200,200,200,0.5)", cursor: "#fc3",
  frozen: "#6af", edge: "#f55", dim: "rgba(0,0,0,0.35)", text: "#eee" };

function draw() {
  const w = canvas.width, h = canvas.height, u = h / 48; // u: a unit for sizes and text
  ctx.fillStyle = "#111";
  ctx.fillRect(0, 0, w, h);
  if (showVideo) {
    ctx.save();
    if (mirror) { ctx.translate(w, 0); ctx.scale(-1, 1); }
    ctx.globalAlpha = 0.45;
    ctx.drawImage(video, 0, 0, w, h);
    ctx.restore();
  }

  // X/Y box: shade outside it
  const b = box();
  ctx.fillStyle = C.dim;
  ctx.fillRect(0, 0, w, b.y0 * h);
  ctx.fillRect(0, b.y1 * h, w, h - b.y1 * h);
  ctx.fillRect(0, b.y0 * h, b.x0 * w, (b.y1 - b.y0) * h);
  ctx.fillRect(b.x1 * w, b.y0 * h, w - b.x1 * w, (b.y1 - b.y0) * h);
  ctx.strokeStyle = C.box;
  ctx.lineWidth = 1.5;
  ctx.setLineDash([u * 0.6, u * 0.6]);
  ctx.strokeRect(b.x0 * w, b.y0 * h, (b.x1 - b.x0) * w, (b.y1 - b.y0) * h);
  ctx.setLineDash([]);
  grid(b, w, h, u);

  // calibration in progress
  if (calibrating) {
    const left = Math.max(0, (calibrating.until - performance.now()) / 1000);
    const msg = "point and hold still at " + calibrating.what;
    text(msg + "  " + left.toFixed(1) + " s", w / 2, h * 0.12, u * 2.2, "center", C.cursor);
  }

  // skeleton: coloured while pointing, grey otherwise; the index fingertip marked
  if (present && last) {
    const { lm } = last;
    ctx.strokeStyle = pointing ? C.bone : C.idle;
    ctx.lineWidth = u * 0.3;
    ctx.beginPath();
    for (const [a, c] of BONES) { ctx.moveTo(lm[a].x * w, lm[a].y * h); ctx.lineTo(lm[c].x * w, lm[c].y * h); }
    ctx.stroke();
    ctx.fillStyle = pointing ? "#fff" : C.idle;
    for (const p of lm) { ctx.beginPath(); ctx.arc(p.x * w, p.y * h, u * 0.35, 0, 7); ctx.fill(); }
    ctx.strokeStyle = pointing ? C.cursor : C.idle;
    ctx.lineWidth = u * 0.2;
    ctx.beginPath(); ctx.arc(lm[8].x * w, lm[8].y * h, u * 0.9, 0, 7); ctx.stroke();
  }

  // cursor at the values being sent (live or frozen), inside the box
  const m = held;
  const cx = (b.x0 + m.x * (b.x1 - b.x0)) * w, cy = (b.y1 - m.y * (b.y1 - b.y0)) * h;
  const col = !pointing ? C.frozen : m.edgeX || m.edgeY ? C.edge : C.cursor;
  ctx.strokeStyle = col;
  ctx.lineWidth = u * 0.25;
  ctx.beginPath();
  ctx.moveTo(b.x0 * w, cy); ctx.lineTo(b.x1 * w, cy);
  ctx.moveTo(cx, b.y0 * h); ctx.lineTo(cx, b.y1 * h);
  ctx.globalAlpha = 0.4; ctx.stroke(); ctx.globalAlpha = 1;
  ctx.beginPath(); ctx.arc(cx, cy, u * (1 + m.z * 2), 0, 7); ctx.stroke();
  ctx.fillStyle = col;
  ctx.beginPath(); ctx.arc(cx, cy, u * 0.5, 0, 7); ctx.fill();

  // Z bar
  bar(w - u * 3, "Z", m.z, !pointing ? C.frozen : m.edgeZ ? C.edge : C.cursor, "near", "far");

  // readouts
  const state = !landmarker ? "loading…" : pointing ? "pointing: live" : present ? "frozen" : "no hand: frozen";
  text(state, u, u * 2.2, u * 1.6, "left", pointing ? C.cursor : C.frozen);
  if (present && last) {
    const names = ["index", "middle", "ring", "pinky"];
    text(names.map((n, i) => (last.straight[i] ? n.toUpperCase() : n)).join("  "), u, u * 4.2, u * 1.1, "left", C.box);
  }
  const V = (v) => (v * 10).toFixed(2) + " V";
  text("X " + V(m.x) + "   Y " + V(m.y) + "   Z " + V(m.z), u, h - u * 1.2, u * 1.5, "left", C.text);
}

// volt grid over the X/Y box: a line per volt (0..10 V = 0..1), brighter at 0, 5 and 10
function grid(b, w, h, u) {
  const X = (v) => (b.x0 + (v / 10) * (b.x1 - b.x0)) * w;
  const Y = (v) => (b.y1 - (v / 10) * (b.y1 - b.y0)) * h;
  for (let v = 0; v <= 10; v++) {
    ctx.strokeStyle = v % 5 === 0 ? "rgba(255,255,255,0.45)" : "rgba(255,255,255,0.16)";
    ctx.lineWidth = v % 5 === 0 ? 1.5 : 1;
    ctx.beginPath();
    ctx.moveTo(X(v), Y(0)); ctx.lineTo(X(v), Y(10));
    ctx.moveTo(X(0), Y(v)); ctx.lineTo(X(10), Y(v));
    ctx.stroke();
    if (v > 0) {
      text(String(v), X(v), Y(0) + u * 1.5, u * 1.1, "center", C.box);
      text(String(v), X(0) - u * 0.6, Y(v) + u * 0.4, u * 1.1, "right", C.box);
    }
  }
  text("0", X(0) - u * 0.6, Y(0) + u * 1.5, u * 1.1, "right", C.box); // origin, lower left
  text("X V", X(10) + u * 0.6, Y(0) + u * 1.5, u * 1.1, "left", C.box);
  text("Y V", X(0) - u * 0.6, Y(10) - u * 1.0, u * 1.1, "right", C.box);
}

function bar(x, label, v, col, top, bottom) {
  const h = canvas.height, u = h / 48;
  const y0 = u * 5, y1 = h - u * 5, bw = u * 1.6;
  ctx.fillStyle = "rgba(0,0,0,0.5)";
  ctx.fillRect(x - bw / 2, y0, bw, y1 - y0);
  ctx.fillStyle = col;
  ctx.fillRect(x - bw / 2, y1 - v * (y1 - y0), bw, v * (y1 - y0));
  ctx.strokeStyle = C.box;
  ctx.lineWidth = 1;
  ctx.strokeRect(x - bw / 2, y0, bw, y1 - y0);
  for (let t = 0; t <= 10; t++) {
    const ty = y1 - (t / 10) * (y1 - y0), long = t % 5 === 0;
    ctx.beginPath(); ctx.moveTo(x - bw / 2 - (long ? u * 0.8 : u * 0.4), ty); ctx.lineTo(x - bw / 2, ty); ctx.stroke();
    if (long) text(String(t), x - bw / 2 - u * 1.1, ty + u * 0.4, u * 1, "right", C.box);
  }
  text(label, x, y0 - u * 2.4, u * 1.4, "center", C.text);
  text(top, x, y0 - u * 0.7, u * 1, "center", C.box);
  text(bottom, x, y1 + u * 1.6, u * 1, "center", C.box);
}

function text(s, x, y, size, align, col) {
  ctx.font = Math.round(size) + "px -apple-system, Helvetica, sans-serif";
  ctx.textAlign = align;
  ctx.fillStyle = "rgba(0,0,0,0.6)";
  ctx.fillText(s, x + 1, y + 1);
  ctx.fillStyle = col;
  ctx.fillText(s, x, y);
}

// ---------- loops ----------

function startLoop() {
  const id = ++loopId;
  if (loopMode === "rvfc" && video.requestVideoFrameCallback) {
    const step = (now, meta) => {
      if (id !== loopId) return;
      track(meta && meta.captureTime);
      video.requestVideoFrameCallback(step);
    };
    video.requestVideoFrameCallback(step);
  } else if (loopMode === "timer") {
    const iv = setInterval(() => { if (id !== loopId) clearInterval(iv); else track(); }, 5);
  } else {
    const step = () => { if (id !== loopId) return; track(); requestAnimationFrame(step); };
    requestAnimationFrame(step);
  }
  out("status", "loop", loopMode);
}

setInterval(() => {
  const up = (performance.now() - t0) / 1000;
  out("stats", frames, frames ? +(inferSum / frames).toFixed(1) : 0,
    latN ? +(latSum / latN).toFixed(1) : -1, Math.round(up), source, loopMode);
  frames = 0; inferSum = 0; latSum = 0; latN = 0;
}, 1000);

// ---------- inlets ----------

bind("calibrate", (what) => {
  what = String(what);
  if (what === "near" || what === "far") startCalibration(what);
  else out("error", "calibrate near or far");
});
bind("calib", (...v) => {
  const [near, far] = v.slice(-2); // the last two: also takes an older stored x0 x1 y0 y1 near far
  if (v.length < 2 || typeof near !== "number" || typeof far !== "number") return;
  Object.assign(cal, { near, far });
});
bind("margin", (v) => { margin = Math.min(0.3, Math.max(0, +v || 0)); });
bind("filter", (mc, beta) => { filt.minCutoff = Math.max(0.01, +mc); filt.beta = Math.max(0, +beta); });
bind("zfilter", (mc, beta) => { zfilt.minCutoff = Math.max(0.01, +mc); zfilt.beta = Math.max(0, +beta); });
bind("straight", (v) => { straightAt = Math.max(-1, Math.min(1, +v)); });
bind("debounce", (v) => { debounce = Math.max(1, Math.round(+v || 1)); });
bind("camera", (...label) => { wantLabel = label.join(" "); if (enabled) openCamera(); });
bind("devices", () => listCameras());
bind("res", (w, h, fps) => { wantW = w; wantH = h; if (fps) wantFps = fps; if (enabled) openCamera(); });
bind("loop", (m) => { loopMode = String(m); if (enabled && landmarker) startLoop(); });
bind("mirror", (v) => { mirror = !!v; });
bind("video", (v) => { showVideo = !!v; });

// ---------- on / off ----------

let enabled = false;

function stopAll() {
  loopId++; // stops the tracking loop
  if (stream) { stream.getTracks().forEach((t) => t.stop()); stream = null; } // the camera light goes off
  video.srcObject = null;
  if (landmarker) { landmarker.close(); landmarker = null; } // frees the model's memory
  if (present) { present = false; setPointing(false, performance.now()); }
  drawOff();
}

function drawOff() {
  const w = canvas.width, h = canvas.height, u = h / 48;
  ctx.fillStyle = "#111";
  ctx.fillRect(0, 0, w, h);
  text("off", w / 2, h / 2, u * 3, "center", C.box);
}

async function setEnabled(on) {
  on = !!on;
  if (on === enabled) return;
  enabled = on;
  if (!on) { stopAll(); out("status", "off"); return; }
  out("status", "on");
  await openCamera();
  if (!enabled) { stopAll(); return; } // switched off while starting
  if (!landmarker) await loadModel();
  if (!enabled) { stopAll(); return; }
  // "ready" is the patch's cue to send the stored calibration
  if (landmarker) { out("status", "ready"); startLoop(); }
}

bind("enable", (v) => { setEnabled(+v); });

// ---------- start ----------

(async () => {
  drawOff();
  // "start" is the patch's cue to send its on/off state
  out("status", "start"); // no arguments, so [route start] bangs
  if (!FilesetResolver) { out("error", "tasks-vision did not load"); return; }
  if (!hasMax) setEnabled(1); // in a plain browser, just start
})();
})();
