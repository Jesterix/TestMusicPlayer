//
//  SearchResult.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 18.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

struct SearchResult: Codable {
    let resultCount: Int
    let results: [SearchItem]
}
