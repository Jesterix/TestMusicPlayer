//
//  DataManager.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//
import Alamofire
import Foundation

final class DataManager {
//    let parameters = ["foo": "bar"]
//
//    // All three of these calls are equivalent
//    AF.request("https://httpbin.org/get", parameters: parameters)
// https://httpbin.org/get?foo=bar


    //https://itunes.apple.com/search?term=dartz


    var searchURL = "https://itunes.apple.com/search"

    func searchRequest(
        for string: String,
        _ completion: @escaping (DataResponse<SearchResult, AFError>) -> Void
    ) {
        let parameters = ["term": string]

        AF.request(searchURL, parameters: parameters)
            .responseDecodable(of: SearchResult.self) { response in
                completion(response)
        }
    }
}
