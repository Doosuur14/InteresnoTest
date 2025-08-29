//
//  BottomOverlays.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI

struct BottomOverlays: View {
    let video: Video

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Friends watching
            HStack(spacing: 6) {
                Image(systemName: "person.2.fill")
                Text("Друзья смотрят: @dasha @anna @pavel")
            }
            .foregroundColor(.white)
            .font(.system(size: 13))

            // Viewers count
            HStack(spacing: 6) {
                Image(systemName: "play.fill")
                Text("15k смотрят эфир")
            }
            .foregroundColor(.white.opacity(0.85))
            .font(.system(size: 12))

            // Location / pin
            HStack(spacing: 8) {
                Image(systemName: "mappin.circle.fill")
                Text("RA'MEN")
                Text("(12)").opacity(0.8)
            }
            .foregroundColor(.white)
            .font(.system(size: 13))

            // Hashtags
            HStack(spacing: 8) {
                ForEach(["#погуляем", "#природа", "#лето"], id: \.self) { tag in
                    Text(tag)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                }
                Spacer()
            }

            // Reactions
            HStack(spacing: 16) {
                reaction("😍", "10k")
                reaction("❤️", "100k")
                reaction("🙈", "5k")
                reaction("👍", "300k")
            }

            // Comment bar
            HStack {
                Text("Добавить комментарий")
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                Spacer()
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 28)
        .background(
            LinearGradient(
                colors: [.clear, .black.opacity(0.6), .black.opacity(0.9)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea(edges: .bottom)
        )
    }

    private func reaction(_ emoji: String, _ count: String) -> some View {
        HStack(spacing: 4) {
            Text(emoji).font(.system(size: 15))
            Text(count).foregroundColor(.white).font(.system(size: 13))
        }
    }
}

