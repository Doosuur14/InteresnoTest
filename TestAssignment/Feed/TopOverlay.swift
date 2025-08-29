//
//  TopOverlay.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI

struct TopOverlay: View {
    let video: Video

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: video.channelAvatar)) { img in
                    img.resizable()
                } placeholder: { Color.gray.opacity(0.35) }
                    .frame(width: UITheme.avatarSize, height: UITheme.avatarSize)
                    .cornerRadius(UITheme.avatarRadius)

                if video.free {
                    Text("Live")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 7).padding(.vertical, 3)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .offset(x: 0, y: 8)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text("@\(video.channelName)")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 14))
                }
                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.85))
                    Text(video.locationText ?? "Россия, Сочи")
                        .foregroundColor(.white.opacity(0.85))
                        .font(.system(size: 12))
                }
            }
            Spacer()
            Text(format(duration: video.durationSec))
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background(Color.white.opacity(0.18))
                .clipShape(Capsule())
        }
    }

    private func format(duration sec: Int) -> String {
        let m = sec / 60, s = sec % 60
        return String(format: "%d:%02d", m, s)
    }
}

