// hando.loader: sends "url file://..." for ../jweb/hando.html, relative to this patch's file,
// so the hando folder can move. Fires shortly after the patch opens (or this script reloads), and on bang.
// Outlet 1: the length of the patch's file path (0 = unsaved or not found), for checking.

autowatch = 1;
inlets = 1;
outlets = 2;

function bang() {
  let file = "";
  try {
    file = String(this.patcher.filepath || "");
  } catch (e) {}
  outlet(1, file.length);
  if (!file) {
    post("hando.loader: save the patch first\n");
    return;
  }
  // Max path "Volume:/a/b" -> POSIX "/a/b" (the boot volume) -> file:// URL
  const posix = file.replace(/^[^/:]*:/, "").replace(/\/patchers\/[^/]*$/, "");
  outlet(0, "url", "file://" + encodeURI(posix + "/jweb/hando.html"));
}

// deferred: a new object or an edited script gets no loadbang, and outlets can't be used during load
const start = new Task(bang, this);
start.schedule(200);
