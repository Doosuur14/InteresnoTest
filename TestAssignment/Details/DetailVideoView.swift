//
//  DetailVideoView.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI
import AVFoundation

struct DetailVideosView: View {
    let videos: [Video]
    let vm: VideoViewModel
    let ns: Namespace.ID
    let startIndex: Int
    let onClose: () -> Void

    @State private var currentIndex: Int

    init(videos: [Video], vm: VideoViewModel, ns: Namespace.ID, startIndex: Int, onClose: @escaping () -> Void) {
        self.videos = videos
        self.vm = vm
        self.ns = ns
        self.startIndex = startIndex
        self.onClose = onClose
        _currentIndex = State(initialValue: startIndex)
    }

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(videos.enumerated()), id: \.1.id) { index, video in
                SingleDetailVideoView(video: video, vm: vm, ns: ns, onClose: onClose)
                    .tag(index)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onChange(of: currentIndex) { newIndex in
            vm.preloadVideo(at: newIndex + 1)
        }
    }
}
