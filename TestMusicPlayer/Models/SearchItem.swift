//
//  SearchItem.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

struct SearchItem: Codable {
    let artistName: String
    let trackName: String
    let artworkPath: String
    let previewUrl: String
    let albumName: String

    enum CodingKeys: String, CodingKey {
        case artistName, trackName, previewUrl
        case artworkPath = "artworkUrl100"
        case albumName = "collectionName"
    }

    static func empty() -> SearchItem {
        return SearchItem(
            artistName: "No tracks found",
            trackName: "",
            artworkPath: "",
            previewUrl: "",
            albumName: "")
    }
}
