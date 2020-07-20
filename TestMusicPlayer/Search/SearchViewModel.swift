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

    private let dataManager: NetworkSearching = DataManager()

    private func search(for string: String) {
        items.value = []
        self.dataManager.search(for: string) { result in
            if let searchResult = result.value {
                if searchResult.results.count == 0 {
                    self.items.value = [SearchItem.empty()]
                } else {
                    self.items.value = searchResult.results
                }
            }
        }
    }

    func prepareToSearch(text: String) {
        if text.count >= 3 {
            search(for: text)
        } else {
            items.value = []
        }
    }
}
