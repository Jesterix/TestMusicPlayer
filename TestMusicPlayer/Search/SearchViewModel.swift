//
//  SearchViewModel.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import Bond

final class SearchViewModel {
    let items = Observable<[SearchItem]>([])
    let error = Observable<Error?>(nil)
    let refreshing = Observable<Bool>(false)

    private let dataManager: DataManager
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func search(for string: String) {
        items.value = []
        self.dataManager.searchRequest(for: string) { result in
            if let searchResult = result.value {
                if searchResult.results.count == 0 {
                    self.items.value = [SearchItem(
                        artistName: "No tracks found",
                        trackName: "",
                        artworkPath: "",
                        previewUrl: "",
                        albumName: "")]
                } else {
                    print(searchResult.results)
                    self.items.value = searchResult.results
                }
            }
        }
    }
}
