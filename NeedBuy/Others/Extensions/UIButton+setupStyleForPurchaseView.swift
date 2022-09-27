//
//  UIButton+setupStyleForPurchaseView.swift
//  NeedBuy
//
//  Created by alexKoro on 21.07.22.
//

import UIKit

extension UIButton {
    func setupStyleForPurchaseView(with title: String, textColor: UIColor) {
        self.backgroundColor = .black
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.lightGray, for: .highlighted)
        self.layer.cornerRadius = 10
    }
}
