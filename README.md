# hando

hando is a Max 9 patch. It uses the camera of a Mac to find the position of one hand. It sends this position as control signals.

The patch finds the tip of your index finger. It also measures the distance of the hand from the camera. The patch sends these values only when you point with your index finger. When you close your hand, the values stay at their last level.

## Requirements

- Max 9. The patch was tested with Max 9.1.5.
- A Mac with a camera. The patch was tested with the built-in camera of a MacBook Pro (M4).
- An internet connection is not necessary. All files are in this folder.

## Installation

1. Put the `hando` folder on your computer.
2. Open `patchers/hando.maxpat` in Max.
3. When macOS asks for camera access, allow it for Max.

If macOS does not ask, open System Settings > Privacy & Security > Camera. Set the switch for Max to on.

## Camera settings

macOS can change the camera image. These changes make the tracking less accurate.

1. Start the camera in hando.
2. Open Control Center > Video Effects.
3. Set Center Stage to off.
4. Set Portrait to off.
5. Set Studio Light to off.
6. Set Reactions to off.

Center Stage moves and zooms the image. Reactions adds animations to the image when it sees some hand gestures.

## Operation

1. Set the on/off toggle to on. The toggle is on when the patch opens.
2. Hold your hand in front of the camera.
3. Point with your index finger. Keep the other fingers closed. The values change with your finger. The gate is 1.
4. Close your hand to a fist. The values stay at their last level. The gate is 0.

The view shows the camera image, the hand, a grid from 0 to 10 V, and the current values. The grid shows the area for X and Y. The bar on the right shows Z.

When hando is off, the camera is off and the model is not in memory.

## Calibration of the Z range

Z is the distance of the hand from the camera. Set the near and far limits for your position.

1. Point with your index finger.
2. Hold your hand at the nearest distance that you will use.
3. Click `calibrate near`.
4. Hold your hand still for 1 second.
5. Move your hand to the farthest distance that you will use.
6. Click `calibrate far`.
7. Hold your hand still for 1 second.

The patch keeps the calibration when you save it.

## Outlets

All outlets send signals. The range of the values is 0 to 1.

| Outlet | Value | 0 | 1 |
|---|---|---|---|
| 1 | X | left | right |
| 2 | Y | bottom | top |
| 3 | Z | far | near |
| 4 | Gate | not pointing | pointing |

X, Y and Z move from one frame to the next in 33 ms (one camera frame). This removes steps in the signals.

## Messages

Send these messages to the `jweb` object to change the settings.

| Message | Function | Default |
|---|---|---|
| `enable 0` or `enable 1` | Stop or start the camera and the tracking | 1 |
| `calibrate near`, `calibrate far` | Set the Z limits (see above) | |
| `filter <cutoff> <beta>` | Smoothing of X and Y. A lower cutoff gives a steadier value. A higher beta gives less delay. | 3 12 |
| `zfilter <cutoff> <beta>` | Smoothing of Z | 0.8 3 |
| `straight <value>` | Limit for a straight finger, from -1 to 1. A higher value needs a straighter finger. | 0.6 |
| `debounce <frames>` | Number of frames that a new hand shape must stay before the patch uses it | 2 |
| `margin <value>` | Makes the X and Y area smaller on each side, from 0 to 0.3. This makes the edges easy to reach. | 0.05 |
| `res <width> <height> [fps]` | Camera image size and frame rate | 1280 960 30 |
| `camera <name>` | Camera to use. Part of the name is sufficient. | MacBook |
| `mirror 0` or `mirror 1` | Mirror image | 1 |
| `video 0` or `video 1` | Show or hide the camera image | 1 |
| `loop timer` or `loop rvfc` | Tracking method. Use `loop timer` if the tracking stops when the Max window is not in front. | rvfc |

The built-in camera of a MacBook Pro gives a maximum of 30 frames per second.

## Privacy

The camera images stay on your computer. The hand tracking uses MediaPipe from Google. Usually, MediaPipe sends usage data to Google. This data does not include images.

hando blocks all network connections from its page. Thus, MediaPipe cannot send this data. When hando blocks a connection, the Max Console shows a `hando: blocked` message.

## Files

| File | Function |
|---|---|
| `patchers/hando.maxpat` | The patch |
| `patchers/hando.loader.js` | Loads the page into the `jweb` object |
| `jweb/hando.html`, `jweb/hando.js` | The page: camera, hand tracking, view |
| `jweb/vendor/tasks-vision@1.0.1/` | MediaPipe Tasks Vision library |
| `jweb/models/hand_landmarker.task` | MediaPipe hand model |

## License

hando is licensed under the MIT License. See `LICENSE`.

The MediaPipe library and the hand model are licensed under the Apache License 2.0. See `THIRD_PARTY_NOTICES.md`.
