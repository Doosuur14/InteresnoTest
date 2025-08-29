//
//  UITheme.swift
//  TestAssignment
//
//  Created by Faki Doosuur Doris on 30.08.2025.
//

import SwiftUI

enum UITheme {
    static let cardCorner: CGFloat = 22
    static let avatarSize: CGFloat = 54
    static let avatarRadius: CGFloat = 12
    static let sidePadding: CGFloat = 12

    static let topGradient = LinearGradient(
        colors: [Color.black.opacity(0.75), Color.black.opacity(0.3), .clear],
        startPoint: .top, endPoint: .bottom)

    static let bottomGradient = LinearGradient(
        colors: [.clear, Color.black.opacity(0.25), Color.black.opacity(0.85)],
        startPoint: .top, endPoint: .bottom)
}

