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
        bindViewModel()
        viewModel.fetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func bindViewModel() {
//        viewModel.refreshing.bind(
//            to: searchView.activityIndicator.reactive.isAnimating)
//        viewModel.items.bind(to: self) { _, _ in
//            self.searchView.tableView.reloadData()
//        }
    }
}


