//
//  Extensions.swift
//  TestMusicPlayer
//
//  Created by Георгий Хайденко on 17.07.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init(frame: .zero)
        self.attributedText = .init(string: text)
    }
}

extension UIViewController {
    internal func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
}
