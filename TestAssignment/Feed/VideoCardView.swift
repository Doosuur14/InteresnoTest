//
//  VideoCardView.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI
import AVFoundation

struct VideoCardView: View {
    let video: Video
    let vm: VideoViewModel
    let ns: Namespace.ID

    @State private var player: AVPlayer?
    @State private var startTask: Task<Void, Never>?
    @State private var didStart = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: UITheme.cardCorner, style: .continuous)
                .fill(Color.black)
                .overlay(
                    Group {
                        if let p = player, didStart {
                            PlayerLayerView(player: p)
                                .clipShape(RoundedRectangle(cornerRadius: UITheme.cardCorner, style: .continuous))
                        } else {
                            AsyncImage(url: URL(string: video.previewImage)) { img in
                                img.resizable().scaledToFill()
                            } placeholder: { Color.gray.opacity(0.25) }
                                .clipShape(RoundedRectangle(cornerRadius: UITheme.cardCorner, style: .continuous))
                        }
                    }
                )
                .overlay(UITheme.topGradient.clipShape(RoundedRectangle(cornerRadius: UITheme.cardCorner)))
                .overlay(UITheme.bottomGradient.clipShape(RoundedRectangle(cornerRadius: UITheme.cardCorner)))
                .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 10) {
                TopOverlay(video: video)
                Spacer()
                BottomOverlay(video: video)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
        }
        .frame(height: max(UIScreen.main.bounds.height * 0.72, 520))
        .onAppear {
            if player == nil, let url = vm.getHLSURL(for: video.id) {
                let p = AVPlayer(url: url)
                p.isMuted = true
                player = p
            }
            startTask?.cancel()
            startTask = Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                guard !Task.isCancelled else { return }
                await MainActor.run {
                    player?.seek(to: .zero)
                    player?.play()
                    didStart = true
                }
            }
        }
        .onDisappear {
            startTask?.cancel()
            player?.pause()
            didStart = false
        }
    }
}

