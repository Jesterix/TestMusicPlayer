//
//  PlayerPageController.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 18.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

final class PlayerPageController: UIViewController {
    private var playerView: PlayerView!
    private var viewModel = PlayerViewModel()

    init(searchItem: SearchItem) {
        super.init(nibName: nil, bundle: nil)
        viewModel.item = searchItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        playerView = PlayerView()
        self.view = playerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.setup(with: viewModel.item)
        playerView.slider.addTarget(
            self,
            action: #selector(sliderDidChange),
            for: .valueChanged)
        playerView.playButton.addTarget(
            self,
            action: #selector(playButtonTapped),
            for: .touchUpInside)
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func bindViewModel() {
        viewModel.observer.isReady.bind(to: self) { _, _ in
            if self.viewModel.observer.isReady.value {
                self.playerView.setupSlider(with: self.viewModel)
            }
        }
        viewModel.currentTimePercent.bind(to: playerView.slider.reactive.value)
        viewModel.currentTimePercent.bind(to: self) { _, _ in
            self.playerView.timeDidChange()
        }
        viewModel.stopPlaying.bind(to: self) { _, _ in
            self.playButtonTapped()
        }
    }

    @objc func sliderDidChange() {
        viewModel.play(at: playerView.slider.value)
        playerView.isPlaying = true
    }

    @objc func playButtonTapped() {
        playerView.isPlaying.toggle()
        viewModel.playerShouldPlay(playerView.isPlaying)
    }
}
