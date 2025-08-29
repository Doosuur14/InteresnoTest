//
//  BottomOverlay.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI

struct BottomOverlay: View {
    let video: Video

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(video.title)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .semibold))
                .lineLimit(3)

            HStack(spacing: 8) {
                ForEach(["#португалия", "#природа", "#лето"], id: \.self) { tag in
                    Text(tag)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .background(Color.white.opacity(0.14))
                        .clipShape(Capsule())
                }
                Spacer()
            }

            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse")
                Text(video.locationText ?? "Россия, Сочи")
                Spacer(minLength: 8)
                Image(systemName: "eye.fill")
                Text("345")
                Image(systemName: "heart.fill")
                Text("2.5k")
            }
            .foregroundColor(.white.opacity(0.9))
            .font(.system(size: 12))
        }
    }
}

