//  micOSApp.swift
//  micOS
//
//  Created by Mohamed on 2025-04-27.
//

import SwiftUI

@main
struct micOSApp: App {
    var body: some Scene {
        MenuBarExtra("", systemImage: "ear.fill") {
            
            Button {
                // Action
            } label: {
                Image(systemName: "mic.circle.fill")
                Text("Noise Cancellation ON")
            }
            
            
        }
    }
}
