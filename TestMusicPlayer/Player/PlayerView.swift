//
//  PlayerView.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 18.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit
import AlamofireImage

final class PlayerView: UIView {
    var albumImageView: UIImageView!
    private var artistNameLabel: UILabel!
    private var trackNameLabel: UILabel!
    private var albumNameLabel: UILabel!
    var playButton: UIButton!
    private var startTimeLabel: UILabel!
    var slider: UISlider!
    private var endTimeLabel: UILabel!

    var activityIndicator: UIActivityIndicatorView!

    init() {
        super.init(frame: .zero)
        layoutContent(in: self)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutContent(in view: UIView) {
        albumImageView = layout(UIImageView()) { make in
            make.top.leading.trailing.equalTo(safeArea).offset(5)
            make.height.equalTo(100)
        }

        artistNameLabel = layout(UILabel(text: "artistNameLabel")) { make in
            make.top.equalTo(albumImageView.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        trackNameLabel = layout(UILabel(text: "trackNameLabel")) { make in
            make.top.equalTo(artistNameLabel.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        albumNameLabel = layout(UILabel(text: "albumNameLabel")) { make in
            make.top.equalTo(trackNameLabel.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        playButton = layout(UIButton(type: .system)) { make in
            make.top.equalTo(albumNameLabel.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(30)
        }

        startTimeLabel = layout(UILabel(text: "startTimeLabel")) { make in
            make.centerY.equalTo(playButton)
            make.leading.equalTo(playButton.trailing).offset(5)
        }

        endTimeLabel = layout(UILabel(text: "endTimeLabel")) { make in
            make.centerY.equalTo(playButton)
            make.trailing.equalToSuperview().offset(-10)
        }

        slider = layout(UISlider()) { make in
            make.centerY.equalTo(playButton)
            make.height.equalTo(5)
            make.leading.equalTo(startTimeLabel.trailing).offset(5)
            make.trailing.equalTo(endTimeLabel.leading).offset(-5)
        }

        activityIndicator = layout(UIActivityIndicatorView()) { make in
            make.center.equalToSuperview()
        }
    }

    private func applyStyle() {
        backgroundColor = .white

        albumImageView.contentMode = .scaleAspectFit

        artistNameLabel.font = .systemFont(ofSize: 13)
        trackNameLabel.font = .systemFont(ofSize: 15)
        albumNameLabel.font = .systemFont(ofSize: 11)

        artistNameLabel.numberOfLines = 0
        trackNameLabel.numberOfLines = 0
        albumNameLabel.numberOfLines = 0

        if #available(iOS 13.0, *) {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            playButton.setImage(UIImage(.play), for: .normal)
        }

        playButton.tintColor = .black
        slider.tintColor = .black

        startTimeLabel.font = .systemFont(ofSize: 10)
        endTimeLabel.font = .systemFont(ofSize: 10)
        
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.medium
        } else {
            activityIndicator.style = UIActivityIndicatorView.Style.gray
        }
    }

    func setup(with model: SearchItem) {
        artistNameLabel.text = model.artistName
        trackNameLabel.text = model.trackName
        albumNameLabel.text = model.albumName
        guard let url = URL(string: model.artworkPath) else {
            return
        }
        albumImageView.af.setImage(withURL: url)
    }
}


