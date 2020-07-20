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
    private var viewModel = SearchViewModel()

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
        searchView.searchTextField.delegate = self

        hideKeyboardOnTap()

        bindViewModel()
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
                return UITableViewCell()
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

        self.navigationController?.pushViewController(
            PlayerPageController(searchItem: viewModel.items.value[indexPath.row]),
            animated: true)
    }
}

extension SearchPageController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if #available(iOS 13.0, *) {
            return true
        } else {

            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText)
                else { return false }
            let updatedText = currentText.replacingCharacters(
                in: stringRange,
                with: string)

            if updatedText.count >= 3 {
                viewModel.search(for: updatedText)
            } else {
                viewModel.items.value = []
            }
            return true
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if text.count >= 3 {
            viewModel.search(for: text)
        } else {
            viewModel.items.value = []
        }
    }
}

