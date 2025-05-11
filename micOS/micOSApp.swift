//  micOSApp.swift
//  micOS
//
//  Created by Mohamed on 2025-04-27.
//

import SwiftUI

@main
struct micOSApp: App {
    
    @StateObject var engine = AudioManager()
    @State private var isActive = false
    
    
    init() {
        guard let denoiseState = rnnoise_create(nil) else {
            fatalError("Failed to create RNNoise state")
        }

        var frame = [Float](repeating: 0, count: 480)
        for i in 0..<480 {
            let sine  = sin(2 * .pi * 440 * Float(i) / 480) * 0.5
            let noise = Float.random(in: -0.3...0.3)
            frame[i] = sine + noise
        }

        print("Before: \(frame.prefix(10).map { String(format: "%.3f", $0) })")
        rnnoise_process_frame(denoiseState, &frame, frame)
        print(" After: \(frame.prefix(10).map { String(format: "%.3f", $0) })")

        rnnoise_destroy(denoiseState)
    }
    
    
    var body: some Scene {
        MenuBarExtra("micOS", systemImage: "waveform") {
            
            Button(action: {
                isActive.toggle()
                if isActive{
                    engine.start()
                } else {
                    engine.stop()
                }
            }) {
                Label(isActive ? "Disable Noise Cancellation" : "Enable Noise Cancellation", systemImage: isActive ? "mic.circle.fill" : "mic.circle")
                    .labelStyle(.titleAndIcon)
            }
            Divider()
            
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Label("Quit", systemImage: "xmark.circle")
                    .labelStyle(.titleAndIcon)
            }
                 
        }
    }
}
