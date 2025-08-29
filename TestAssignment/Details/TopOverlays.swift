//
//  TopOverlays.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI

struct TopOverlays: View {
    let video: Video
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Back + Share
            HStack {
                Button(action: onClose) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                Spacer()
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            }

            // Avatar + Channel + Title
            HStack(alignment: .top, spacing: 12) {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: video.channelAvatar)) { img in
                        img.resizable()
                    } placeholder: { Color.gray.opacity(0.3) }
                        .frame(width: 58, height: 58)
                        .cornerRadius(12)

                    if video.free {
                        Text("Live")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red)
                            .clipShape(Capsule())
                            .offset(x: 0, y: 8)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Text(video.channelName)
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .semibold))
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 14))
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.white.opacity(0.85))
                            .font(.system(size: 13))
                        Text(video.locationText ?? "Россия, Сочи")
                            .foregroundColor(.white.opacity(0.9))
                            .font(.system(size: 13))
                    }

                    // 👇 Moved inside here so it sits under channel + location
                    Text(video.title)
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .lineLimit(3)
                        .padding(.top, 2)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 40)
        .background(
            LinearGradient(
                colors: [Color.black.opacity(0.7), Color.black.opacity(0.3), .clear],
                startPoint: .top, endPoint: .bottom
            )
        )
    }
}
