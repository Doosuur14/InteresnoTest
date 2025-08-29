//
//  TestAssignmentApp.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI
import AVFoundation

@main
struct TestAssignmentApp: App {

    init() {
        do {
            let audio = AVAudioSession.sharedInstance()
            try audio.setCategory(.playback, mode: .moviePlayback, options: [.defaultToSpeaker])
            try audio.setActive(true)
        } catch {
            print("Audio session setup failed:", error.localizedDescription)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            FeedView()
        }
    }
}
