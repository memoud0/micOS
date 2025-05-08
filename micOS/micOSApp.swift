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
