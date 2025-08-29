//
//  VideoItem.swift
//  InteresnoTest
//
//  Created by Faki Doosuur Doris on 28.08.2025.
//

import Foundation

struct Video: Codable, Identifiable {
    let videoId: Int
    let title: String
    let previewImage: String
    let postImage: String?
    let channelId: Int
    let channelName: String
    let channelAvatar: String
    let numbersViews: Int
    let durationSec: Int
    let free: Bool
    let vertical: Bool
    let seoUrl: String
    let datePublication: String
    let draft: Bool
    let timeNotReg: Int?
    let timeNotPay: Int?
    let hasAccess: Bool
    let contentType: String
    let latitude: Double?
    let longitude: Double?
    let locationText: String?
    let playlistId: Int?

    // Identifiable conformance
    var id: Int { videoId }
}

struct Filter: Codable {
    let search: String?
    let videoId: Int?
    let category: String?
    let channelId: Int?
    let userId: Int?
    let isFree: Bool?
    let authRequired: Bool?
    let datePeriod: String?
    let dateFilterType: String?
    let sortBy: String?
    let sortOrder: String?
}

struct VideoResponse: Codable {
    let total: Int
    let offset: Int
    let limit: Int
    let count: Int
    let filter: Filter
    let items: [Video]
}
