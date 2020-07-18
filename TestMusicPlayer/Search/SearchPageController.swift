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
//    private let reuseID = "hotelCell"

//    init(viewModel: HotelsViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func loadView() {
        searchView = SearchView()
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
//        mainView.tableView.register(
//            HotelCell.self,
//            forCellReuseIdentifier: reuseID)
//
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
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.items.value[indexPath.row].trackName
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: reuseID) as? HotelCell else {
//                fatalError("invalid cell type")
//        }
//
//        cell.nameLabel.text = viewModel.hotels.value[indexPath.row].name
//        cell.distanceLabel.text = "Distance from center: " + String(viewModel.hotels.value[indexPath.row].distance)
//        cell.suitesAvailableLabel.text = "Available suites: \(viewModel.hotels.value[indexPath.row].suitesAvailability.count)"

        return cell
    }
}

extension SearchPageController: UITableViewDelegate {
//    func tableView(
//        _ tableView: UITableView,
//        didSelectRowAt indexPath: IndexPath
//    ) {
//        tableView.deselectRow(at: indexPath, animated: false)
//
//        self.navigationController?.pushViewController(
//            DetailViewController(hotel: self.viewModel.hotels.value[indexPath.row]),
//            animated: true)
//    }
}

