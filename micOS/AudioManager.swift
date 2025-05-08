//
//  AudioManager.swift
//  micOS
//
//  Created by Mohamed on 2025-05-07.
//

import AVFoundation

class AudioManager: ObservableObject {
    let engine = AVAudioEngine()
    private var isRunning = false
    
    private let toneNode = AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
        let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
        let sampleRate = 44100.0
        let frequency = 880.0 // A5 note
        let amplitude = 0.1

        for frame in 0..<Int(frameCount) {
            let sample = Float(sin(2.0 * .pi * frequency * Double(frame) / sampleRate)) * Float(amplitude)
            for buffer in ablPointer {
                let buf: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                buf[frame] = sample
            }
        }

        return noErr
    }

    
    init() {
        print("AudioManager initialized")
    }
    
    func start() {
        guard !isRunning else { return }
        let inputNode = engine.inputNode
        let outputNode = engine.outputNode
        let format = inputNode.inputFormat(forBus: 0)
        
        engine.disconnectNodeInput(engine.mainMixerNode)
        engine.disconnectNodeOutput(inputNode)
        
        if engine.attachedNodes.contains(toneNode) {
            engine.disconnectNodeOutput(toneNode)
        } else {
            engine.attach(toneNode)
        }
        
        engine.attach(toneNode)
        engine.connect(inputNode, to: engine.mainMixerNode, format: format)
        engine.connect(toneNode, to: engine.mainMixerNode, format: format)
        engine.connect(engine.mainMixerNode, to: outputNode, format: format)
        
        do {
            try engine.start()
            isRunning = true
            print("AVAudioEngine started")
        } catch {
            print("Failed to start engine: \(error.localizedDescription)")
        }
        
    }
    
    func stop(){
        engine.stop()
        isRunning = false
        print("Audio engine stopped")
    }
}
