//
//  SearchPageController.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

final class SearchPageController: UIViewController {
    private var searchView: SearchView!
    private var viewModel = SearchViewModel(dataManager: DataManager())

    override func loadView() {
        searchView = SearchView()
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        searchView.tableView.register(
            SearchCell.self,
            forCellReuseIdentifier: SearchCell.reuseID)

        bindViewModel()
        viewModel.search(for: "abba")
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    private func bindViewModel() {
        viewModel.refreshing.bind(
            to: searchView.activityIndicator.reactive.isAnimating)
        viewModel.items.bind(to: self) { _, _ in
            self.searchView.tableView.reloadData()
        }
    }
}

extension SearchPageController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.items.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchCell.reuseID) as? SearchCell else {
                fatalError("invalid cell type")
        }
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
}

extension SearchPageController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)

//        self.navigationController?.pushViewController(
//            DetailViewController(hotel: self.viewModel.hotels.value[indexPath.row]),
//            animated: true)
    }
}

