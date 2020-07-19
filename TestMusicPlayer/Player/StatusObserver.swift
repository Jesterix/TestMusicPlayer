//
//  StatusObserver.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 20.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import Bond
import AVFoundation

class StatusObserver: NSObject {
    var isReady = Observable<Bool>(false)
    var playerItemContext = 0

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        // Only handle observations for the playerItemContext
        guard context == &playerItemContext else {
            super.observeValue(
                forKeyPath: keyPath,
                of: object,
                change: change,
                context: context)
            return
        }

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status

            // Get the status change from the change dictionary
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            isReady.value = status == .readyToPlay
        }
    }
}
