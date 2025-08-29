//
//  ContentView.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//
import SwiftUI
import AVFoundation

struct FeedView: View {
    @StateObject private var vm = VideoViewModel()
    @Namespace private var ns
    
    var body: some View {
        NavigationStack {
            ZStack {
                content   
            }
            .background(Color.black.ignoresSafeArea())
            .overlay(BottomBar().padding(.bottom, 10), alignment: .bottom)
            .navigationDestination(for: Video.self, destination: destination(for:))
            .navigationBarHidden(true)
            .task {
                if vm.videos.isEmpty {
                    await vm.fetchVideos()
                }
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if let error = vm.error {
            Text("Error: \(error)").foregroundColor(.red)
        } else if vm.videos.isEmpty {
            ProgressView().tint(.white)
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    ForEach(vm.videos) { video in
                        NavigationLink(value: video) {
                            VideoCardView(video: video, vm: vm, ns: ns)
                                .padding(.horizontal, UITheme.sidePadding)
                        }
                    }
                }
                .padding(.vertical, 10)
            }
        }
    }
    
    @ViewBuilder
    private func destination(for video: Video) -> some View {
        if let startIndex = vm.videos.firstIndex(where: { $0.id == video.id }) {
            DetailVideosView(
                videos: vm.videos,
                vm: vm,
                ns: ns,
                startIndex: startIndex,
                onClose: { }
            )
            .toolbar(.hidden, for: .tabBar)
//            .navigationBarBackButtonHidden(true)

        }
    }
}
