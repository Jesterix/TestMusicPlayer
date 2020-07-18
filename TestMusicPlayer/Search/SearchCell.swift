//
//  SearchCell.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 18.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    static var reuseID = "SearchCell"

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutContent(in: self)
        applyStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var artistLabel: UILabel!
    var trackLabel: UILabel!

    private func layoutContent(in view: UIView) {
        artistLabel = view.layout(UILabel()) { make in
            make.leading.equalTo(safeArea).offset(10)
            make.top.equalTo(safeArea).offset(5)
            make.trailing.equalTo(safeArea).offset(-10)
        }

        trackLabel = view.layout(UILabel()) { make in
            make.top.equalTo(artistLabel.bottom).offset(2)
            make.leading.equalTo(artistLabel)
            make.bottom.equalTo(safeArea).offset(-10)
        }
    }

    private func applyStyle() {
        artistLabel.numberOfLines = 0
        trackLabel.numberOfLines = 0
        artistLabel.font = .systemFont(ofSize: 17)
        trackLabel.font = .systemFont(ofSize: 13)
    }

    func configure(with model: SearchItem) {
        artistLabel.text = model.artistName
        trackLabel.text = model.trackName
    }
}
