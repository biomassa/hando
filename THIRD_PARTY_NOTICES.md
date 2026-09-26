# Third-party notices

hando is licensed under the MIT License (see `LICENSE`). This repository also contains third-party files. These files keep their own licenses, as given below.

## MediaPipe Tasks Vision 1.0.1

- Location: `jweb/vendor/tasks-vision@1.0.1/`
- Source: npm package `@mediapipe/tasks-vision`, version 1.0.1 (https://www.npmjs.com/package/@mediapipe/tasks-vision)
- Copyright: Google LLC and the MediaPipe authors
- License: Apache License 2.0 (the `license` field in the package's `package.json`)
- License text: `jweb/vendor/tasks-vision@1.0.1/LICENSE`. This is the `LICENSE` file of the MediaPipe repository (https://github.com/google-ai-edge/mediapipe). It contains the Apache License 2.0 and a notice from Lucent Technologies for one part of the MediaPipe source.
- NOTICE file: the MediaPipe project does not supply one.

The files in this repository are the package's original files, not modified. They are:

- `vision_bundle.cjs`
- `wasm/vision_wasm_internal.js`, `wasm/vision_wasm_internal.wasm`
- `wasm/vision_wasm_nosimd_internal.js`, `wasm/vision_wasm_nosimd_internal.wasm`
- `package.json`, `README.md`

The package's other files are not included. hando does not use them.

## MediaPipe Hand Landmarker model

- Location: `jweb/models/hand_landmarker.task`
- Source: https://storage.googleapis.com/mediapipe-models/hand_landmarker/hand_landmarker/float16/1/hand_landmarker.task
- Copyright: Google LLC
- License: Apache License 2.0. The model card says: "LICENSED UNDER Apache License, Version 2.0" (Model Card Hand Tracking (Lite/Full) with Fairness, October 2021, page 2: https://storage.googleapis.com/mediapipe-assets/Model%20Card%20Hand%20Tracking%20(Lite_Full)%20with%20Fairness%20Oct%202021.pdf)
- License text: `jweb/models/LICENSE`
- The file is the original file, not modified.

## MediaPipe usage metrics

The MediaPipe Tasks privacy notice (in the package's `README.md`) says that the library sends metrics about performance and usage to Google. It does not send camera images. hando blocks all network requests from its page (`jweb/hando.html`, Content-Security-Policy `connect-src file: blob: data:`), so these metrics are not sent.
