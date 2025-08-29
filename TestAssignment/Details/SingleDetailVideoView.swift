//
//  SingleDetailVideoView.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI
import AVFoundation

struct SingleDetailVideoView: View {
    let video: Video
    let vm: VideoViewModel
    let ns: Namespace.ID
    let onClose: () -> Void

    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if let p = player {
                PlayerLayerView(player: p)
                    .ignoresSafeArea()
            } else {
                Color.black.ignoresSafeArea()
            }

            VStack {
                TopOverlays(video: video, onClose: onClose)
                Spacer()
                BottomOverlays(video: video)
            }
        }
        .onAppear {
            if let url = vm.getHLSURL(for: video.id) {
                let p = AVPlayer(url: url)
                p.isMuted = false
                p.play()
                player = p
            }
        }
        .onDisappear { player?.pause() }
    }
}

