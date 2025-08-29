//
//  ContentView.swift
//  InteresnoTest
//
//  Created by Faki Doosuur Doris on 27.08.2025.
//

import SwiftUI
import AVKit

struct FeedView: View {
    @StateObject private var viewModel = VideoViewModel()

    var body: some View {
        NavigationStack {
            if let error = viewModel.error {
                Text("Error: \(error)").foregroundColor(.red)
            } else if viewModel.videos.isEmpty {
                ProgressView().onAppear {
                    Task { await viewModel.fetchVideos() }
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.videos) { video in
                            NavigationLink(destination: VideoPlayerView(video: video, viewModel: viewModel)) {
                                VideoPreviewCell(video: video, viewModel: viewModel)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                        }
                    }
                }
                .background(Color.black)
                .safeAreaInset(edge: .bottom) {
                    HStack(spacing: 20) {
                        Image(systemName: "house").foregroundColor(.white)
                        Image(systemName: "bell").foregroundColor(.white)
                        Image(systemName: "plus.circle").foregroundColor(.white)
                        Image(systemName: "message").foregroundColor(.white)
                        AsyncImage(url: URL(string: viewModel.videos.first?.channelAvatar ?? "")) { image in
                            image.resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        } placeholder: {
                            Circle().fill(Color.gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

struct VideoPreviewCell: View {
    let video: Video
    let viewModel: VideoViewModel
    @State private var player: AVPlayer?
    @State private var isPlaying = false

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: video.channelAvatar)) { image in
                    image.resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Circle().fill(Color.gray)
                        .frame(width: 50, height: 50)
                }
                Text("@" + video.channelName)
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)

            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color.black)
                    .shadow(radius: 6, y: 2)

                if isPlaying, let url = viewModel.getHLSURL(for: video.videoId), let player = player {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.isMuted = true
                            player.play()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(6)
                } else {
                    AsyncImage(url: URL(string: video.previewImage)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(6)
                }
            }
            .frame(height: max(UIScreen.main.bounds.height * 0.72, 520))
            .clipped()
        }
        .background(Color.clear)
        .contentShape(Rectangle())
        .onAppear {
            if let url = viewModel.getHLSURL(for: video.videoId) {
                player = AVPlayer(url: url)
                isPlaying = true
            }
        }
        .onDisappear {
            player?.pause()
            isPlaying = false
            player = nil
        }
    }
}
