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
        self.dataManager.searchRequest(for: string) { result in
            if let searchResult = result.value {
                if searchResult.results.count == 0 {
                    print("no items")
                } else {
                    print(searchResult.results[0].trackName)
                    self.items.value = searchResult.results
                }
            }
        }
    }
}
