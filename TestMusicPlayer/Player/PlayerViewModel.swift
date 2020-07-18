//
//  PlayerViewModel.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 18.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import Bond

final class PlayerViewModel {
    var item: SearchItem = SearchItem.empty()


//    let items = Observable<[SearchItem]>([])
//    let error = Observable<Error?>(nil)
//    let refreshing = Observable<Bool>(false)

    private let dataManager: DataManager = DataManager()

    func fetch() {
        //get image data and audio data
    }
}

