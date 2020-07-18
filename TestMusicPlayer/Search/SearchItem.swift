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

//    enum CodingKeys: String, CodingKey {
//        case artistName, trackName
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        artistName = try container.decode(String.self, forKey: .artistName)
//        trackName = try container.decode(String.self, forKey: .trackName)
//    }
}

struct SearchResult: Codable {
    let resultCount: Int
    let results: [SearchItem]
}
