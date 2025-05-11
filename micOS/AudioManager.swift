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

    private var currentPhase: Double = 0

    private lazy var toneNode = AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
        let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
        
        let sampleRate       = 44_100.0
        let frequency        = 880.0
        let amplitude        = 0.1
        let phaseIncrement   = 2 * .pi * frequency / sampleRate

        for frame in 0..<Int(frameCount) {
            let sample = Float(sin(self.currentPhase)) * Float(amplitude)
            self.currentPhase += phaseIncrement
            if self.currentPhase >= 2 * .pi {
                self.currentPhase -= 2 * .pi
            }
            
            // write it into every channel buffer
            for buffer in ablPointer {
                let buf = UnsafeMutableBufferPointer<Float>(buffer)
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

        currentPhase = 0

        if !engine.attachedNodes.contains(toneNode) {
            engine.attach(toneNode)
        }

        let output = engine.outputNode
        let format = output.inputFormat(forBus: 0)

        engine.connect(toneNode, to: output, format: format)

        do {
            try engine.start()
            isRunning = true
            print("Tone started")
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
