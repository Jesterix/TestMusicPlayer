//
//  DataManager.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//
import Alamofire

protocol NetworkSearching {
    func search(
        for string: String,
        _ completion: @escaping (DataResponse<SearchResult, AFError>) -> Void)
}

final class DataManager: NetworkSearching {
    private var searchURL = "https://itunes.apple.com/search"

    func search(
        for string: String,
        _ completion: @escaping (DataResponse<SearchResult, AFError>) -> Void
    ) {
        let parameters = ["term": string, "entity": "song"]

        AF.request(searchURL, parameters: parameters)
            .responseDecodable(of: SearchResult.self) { response in
                completion(response)
        }
    }
}
