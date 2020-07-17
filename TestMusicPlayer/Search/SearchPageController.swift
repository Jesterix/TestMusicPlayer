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
//    private var viewModel: HotelsViewModel
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
//        mainView.tableView.dataSource = self
//        mainView.tableView.delegate = self
//        mainView.tableView.register(
//            HotelCell.self,
//            forCellReuseIdentifier: reuseID)
//
//        bindViewModel()
//        viewModel.fetch()
//
//        mainView.switchControl.addTarget(
//            self,
//            action: #selector(sortHotels),
//            for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

//    private func bindViewModel() {
//        viewModel.refreshing.bind(
//            to: mainView.activityIndicator.reactive.isAnimating)
//        viewModel.hotels.bind(to: self) { _, _ in
//            self.mainView.tableView.reloadData()
//        }
//    }

//    @objc private func sortHotels() {
//        if mainView.switchControl.isOn {
//            viewModel.hotels.value.sort
//                { $0.suitesAvailability.count < $1.suitesAvailability.count }
//        } else {
//            viewModel.hotels.value.sort
//                { $0.distance < $1.distance }
//        }
//        mainView.tableView.reloadData()
//    }
}

extension SearchPageController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: reuseID) as? HotelCell else {
//                fatalError("invalid cell type")
//        }
//
//        cell.nameLabel.text = viewModel.hotels.value[indexPath.row].name
//        cell.distanceLabel.text = "Distance from center: " + String(viewModel.hotels.value[indexPath.row].distance)
//        cell.suitesAvailableLabel.text = "Available suites: \(viewModel.hotels.value[indexPath.row].suitesAvailability.count)"

        return UITableViewCell()
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

