//
//  InteresnoTestApp.swift
//  InteresnoTest
//
//  Created by Faki Doosuur Doris on 27.08.2025.
//

import SwiftUI
import AVFoundation

@main
struct InteresnoTestApp: App {
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            FeedView()
        }
    }
}
