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
    //Data
    var item: SearchItem = SearchItem.empty() {
        didSet {
            setupPlayer()
        }
    }
    //Player
    private var player: AVPlayer?
    //Observable values
    let observer = StatusObserver()
    var currentTimePercent = Observable<Float>(0)
    let trackDidEndPlaying = Observable<Bool>(false)

    var duration: Float {
        guard let player = player, let item = player.currentItem else {
            return 0
        }
        let seconds: Float64 = CMTimeGetSeconds(item.duration)
        return Float(seconds)
    }

    private func setupPlayer() {
        guard let url = URL(string: item.previewUrl) else {
            return
        }
        let playerItem = AVPlayerItem(url: url)

        playerItem.addObserver(
            observer,
            forKeyPath: #keyPath(AVPlayerItem.status),
            options: [.old, .new],
            context: &observer.playerItemContext)
        player = AVPlayer(playerItem: playerItem)

        player!.addPeriodicTimeObserver(
            forInterval: CMTime(
                seconds: 0.1,
                preferredTimescale: CMTimeScale(NSEC_PER_SEC)),
            queue: DispatchQueue.main) { [weak self] time in
                guard let self = self else { return }

                self.currentTimePercent.value = Float(CMTimeGetSeconds(time))
                if self.currentTimePercent.value >= self.duration {
                    self.trackDidEndPlaying.value = true
                }
        }
    }

    func play(at time: Float) {
        guard let player = player else { return }

        let seconds : Int64 = Int64(time)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        if player.rate == 0
        {
            player.play()
        }
    }

    func playerShouldPlay(_ play: Bool) {
        guard let player = player else { return }
        if play {
            player.play()
        } else {
            player.pause()
        }
    }
}

