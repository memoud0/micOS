//  micOSApp.swift
//  micOS
//
//  Created by Mohamed on 2025-04-27.
//

import SwiftUI

@main
struct micOSApp: App {
    
    @State private var isActive = false
    
    var body: some Scene {
        MenuBarExtra("", systemImage: "ear.fill") {
            
            Button(action: {
                isActive.toggle()
            }) {
                Label(isActive ? "Disable Noise Cancellation" : "Enable Noise Cancellation", systemImage: isActive ? "mic.circle.fill" : "mic.circle")
                    .labelStyle(.titleAndIcon)
            }
            Divider()
            
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Label("Quit", systemImage: isActive ? "ear.circle.fill" : "ear.circle")
                    .labelStyle(.titleAndIcon)
            }
            
            
            
            
        }
    }
}
