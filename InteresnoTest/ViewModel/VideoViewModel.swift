//
//  VideoViewModel.swift
//  InteresnoTest
//
//  Created by Faki Doosuur Doris on 28.08.2025.
//

import Foundation

@MainActor
final class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var error: String?

    func fetchVideos() async {
        let urlString = "https://interesnoitochka.ru/api/v1/videos/recommendations?offset=0&limit=10&category=shorts&date_filter_type=created&sort_by=date_created&sort_order=desc"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(VideoResponse.self, from: data)
            videos = response.items

        } catch {
            self.error = error.localizedDescription 
        }
    }

    func getHLSURL(for videoId: Int) -> URL?  {
        let urlString = "https://interesnoitochka.ru/api/v1/videos/video/\(videoId)/hls/playlist.m3u8"
        return URL(string: urlString)
    }
}
