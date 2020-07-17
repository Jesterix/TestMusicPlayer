//
//  SearchView.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

final class SearchView: UIView {
    var titleLabel: UILabel!
    var searchTextField: UITextField!
    var tableView: UITableView!
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
        titleLabel = layout(UILabel(text: "Search for music")) { make in
            make.top.equalTo(safeArea).offset(20)
            make.centerX.equalToSuperview()
        }

        searchTextField = layout(UITextField()) { make in
            make.top.equalTo(titleLabel.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        tableView = layout(UITableView()) { make in
            make.top.equalTo(searchTextField.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(safeArea)
        }

        activityIndicator = layout(UIActivityIndicatorView()) { make in
            make.center.equalToSuperview()
        }
    }

    private func applyStyle() {
        backgroundColor = .white

        searchTextField.autocorrectionType = .no
        searchTextField.placeholder = "Enter music track name"

        tableView.separatorStyle = .none

        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.medium
        } else {
            activityIndicator.style = UIActivityIndicatorView.Style.gray
        }
    }
}

