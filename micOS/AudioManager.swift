//
//  AudioManager.swift
//  micOS
//
//  Created by Mohamed on 2025-05-07.
//

import AVFoundation

class AudioManager {
    let engine = AVAudioEngine()
    let inputNode: AVAudioInputNode
    let outputNode: AVAudioOutputNode
    
    init() {
        inputNode = engine.inputNode
        outputNode = engine.outputNode
        
        let inputFormat = inputNode.inputFormat(forBus: 0)
        
        engine.connect(inputNode, to: engine.mainMixerNode, format: inputFormat)
        engine.connect(engine.mainMixerNode, to: outputNode, format: inputFormat)
        
        do {
            try engine.start()
            print("AVAudioEngine started")
        } catch {
            print("Failed to start engine: \(error.localizedDescription)")
        }
        
    }
}
