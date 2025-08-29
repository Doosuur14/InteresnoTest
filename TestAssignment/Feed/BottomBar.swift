//
//  BottomBar.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: "house.fill")
            Image(systemName: "bell")
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.white)
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            }
            Image(systemName: "message")
            Image(systemName: "person.crop.circle")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial, in: Capsule())
        .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 6)
    }
}

