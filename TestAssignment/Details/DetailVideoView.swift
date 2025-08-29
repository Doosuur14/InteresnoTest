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

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(videos, id: \.id) { video in
                    SingleDetailVideoView(video: video, vm: vm, ns: ns, onClose: onClose)
                        .frame(height: UIScreen.main.bounds.height)
                }
            }
        }
        .ignoresSafeArea()
    }
}

