//
//  PlayerViewModel.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 18.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import Bond
import AVFoundation

final class PlayerViewModel {
    var item: SearchItem = SearchItem.empty() {
        didSet {
            setupPlayer()
        }
    }

    let player = Observable<AVPlayer?>(nil)
    private var playerItem: AVPlayerItem?

    var duration: Float {
        guard let playerItem = playerItem else {
            return 0
        }
        let seconds: Float64 = CMTimeGetSeconds(playerItem.duration)
        return Float(seconds)
    }

    var isReadyToPlay: Bool {
        guard let item = playerItem, item.status == .readyToPlay else {
            return false
        }
        return true
    }

    private func setupPlayer() {
        guard let url = URL(string: item.previewUrl) else {
            return
        }
        playerItem = AVPlayerItem(url: url)
        player.value = AVPlayer(playerItem: playerItem)
    }

//    let items = Observable<[SearchItem]>([])
//    let error = Observable<Error?>(nil)
//    let refreshing = Observable<Bool>(false)
}

