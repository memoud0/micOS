//
//  main.swift
//  RNNoiseTester
//
//  Created by Mohamed on 2025-05-11.
//

import Foundation
import AVFoundation

print("start")
let inputURL  = URL(fileURLWithPath: "/input.wav")
let outputURL = URL(fileURLWithPath: "output.wav")

let inFile  = try AVAudioFile(forReading:  inputURL)
let format  = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                            sampleRate: 48_000,
                            channels: 1,
                            interleaved: false)!
let outFile = try AVAudioFile(forWriting:  outputURL,
                              settings: format.settings)

guard let rnState = rnnoise_create(nil) else {
    fatalError("Couldn’t create RNNoise state")
}

let frameCapacity = AVAudioFrameCount(480)
guard let buffer = AVAudioPCMBuffer(pcmFormat: format,
                                    frameCapacity: frameCapacity) else {
    fatalError("Failed to make PCM buffer")
}

while true {
    try inFile.read(into: buffer)
    let n = Int(buffer.frameLength)
    if n < 480 {
        break
    }

    let data = buffer.floatChannelData![0]
    var frame     = Array(UnsafeBufferPointer(start: data, count: 480))
    var outFrame  = frame

    rnnoise_process_frame(rnState, &outFrame, frame)

    for i in 0..<480 {
        data[i] = outFrame[i]
    }
    try outFile.write(from: buffer)
}


rnnoise_destroy(rnState)
print("Wrote denoised file to \(outputURL.path)")





