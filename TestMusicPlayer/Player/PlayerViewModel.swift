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

    var currentTimePercent = Observable<Float>(0)

    var duration: Float {
        guard let playerItem = playerItem else {
            return 0
        }
        let seconds: Float64 = CMTimeGetSeconds(playerItem.duration)
        return Float(seconds)
    }

    var isReadyToPlay = Observable<Bool>(false)

    private func setupPlayer() {
        guard let url = URL(string: item.previewUrl) else {
            return
        }
        playerItem = AVPlayerItem(url: url)
        player.value = AVPlayer(playerItem: playerItem)
        player.value?.addPeriodicTimeObserver(
            forInterval: CMTime(
                seconds: 0.1,
                preferredTimescale: CMTimeScale(NSEC_PER_SEC)),
            queue: DispatchQueue.main) { [weak self] time in
                guard let self = self, let item = self.playerItem, item.status == .readyToPlay else { return }

                if !self.isReadyToPlay.value {
                    self.isReadyToPlay.value = true
                }

                self.currentTimePercent.value = Float(CMTimeGetSeconds(time))
        }
    }

    func play(at time: Float) {
        guard let player = player.value else { return }

        let seconds : Int64 = Int64(time)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        if player.rate == 0
        {
            player.play()
        }
    }
}

