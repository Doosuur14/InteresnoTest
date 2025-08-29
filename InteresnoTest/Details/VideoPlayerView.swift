//
//  VideoPlayerView.swift
//  InteresnoTest
//
//  Created by Faki Doosuur Doris on 28.08.2025.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoPlayerView: View {
    let video: Video
    let viewModel: VideoViewModel
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    private var formattedDuration: String {
        let minutes = video.durationSec / 60
        let seconds = video.durationSec % 60
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                AsyncImage(url: URL(string: video.channelAvatar)) { image in
                    image.resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    Circle().fill(Color.gray)
                        .frame(width: 40, height: 40)
                }
                
                VStack(alignment: .leading) {
                    Text("@" + video.channelName)
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(video.locationText ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
                Spacer()
                if !video.free {
                    Text("Live")
                        .foregroundColor(.red)
                        .padding(5)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                }
                Text(formattedDuration)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.top, 50)
            .background(Color.black.opacity(0.6))
            
            
            GeometryReader { geo in
                ZStack {
                    if let url = viewModel.getHLSURL(for: video.videoId), let player = player {
                        VideoPlayer(player: player)
                            .onAppear {
                                startPlaybackIfReady()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .frame(width: geo.size.width, height: geo.size.height)
                            .padding(.horizontal, 12)
                    } else {
                        ProgressView()
                            .task {
                                if player == nil, let url = viewModel.getHLSURL(for: video.videoId) {
                                    player = AVPlayer(url: url)
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
            }
            .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 10) {
                HStack {
                    Text("#learning #reels #videos")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                    Spacer()
                }
                HStack(spacing: 15) {
                    Text("😊 \(video.numbersViews/1000)k")
                    Text("❤️ 100k")
                    Text("👍 300k")
                    Text("🔄 567")
                }
                .foregroundColor(.white)
                .font(.caption)
                
                Button(action: {
                    // comment action
                }) {
                    Text("Добавить комментарий")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.black.opacity(0.6))
        }
        .background(Color.black)
        .onAppear {
            if player == nil, let url = viewModel.getHLSURL(for: video.videoId) {
                player = AVPlayer(url: url)
            }
            startPlaybackIfReady()
            isPlaying = true
        }
        .onDisappear {
            player?.pause()
            isPlaying = false
            
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 150 {
                        // optionally dismiss
                    }
                }
        )
    }
    
    private func startPlaybackIfReady() {
        guard let player = player else { return }
        
        do {
            let audio = AVAudioSession.sharedInstance()
            try audio.setCategory(.playback, mode: .moviePlayback, options: [.defaultToSpeaker])
            try audio.setActive(true)
            player.isMuted = false
            player.volume = 1.0
            player.play()
        } catch {
            print("Audio session error: \(error)")
        }
    }
}
