# macOS Noise Cancellation App

A native macOS menu bar application providing real-time noise suppression across all applications, including FaceTime, Zoom, and Discord. The app captures microphone input, processes it through a noise suppression pipeline, and outputs the cleaned audio via a virtual audio device.


https://github.com/user-attachments/assets/d494fbc1-6268-4fc0-b17d-bc5492a181de



## Project 

- Implemented SwiftUI-based menu bar interface.
- Configured [BlackHole](https://github.com/ExistentialAudio/BlackHole) virtual audio device for audio routing.
- Integrated `AudioManager` using `AVAudioEngine` for real-time audio capture and processing.

---

## Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Audio Processing:** AVFoundation, AVAudioEngine
- **Virtual Audio Device:** BlackHole
- **Noise Suppression:** RNNoise (C library)

---

## Architecture Overview

1. **User Interface:** SwiftUI-based menu bar app for user interaction.
2. **Audio Capture:** `AVAudioEngine` captures live microphone input.
3. **Noise Suppression:** (Planned) Integrate RNNoise for real-time noise reduction.
4. **Audio Output:** Processed audio routed through BlackHole to be used by other applications.

---
