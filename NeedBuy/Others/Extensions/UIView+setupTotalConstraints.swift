//
//  UIView+setupTotalConstraints.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//

import Foundation
import UIKit

extension UIView {
    func setupTotalConstraints(with view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTotalConstraints(with view: UIView, constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        ])
    }
}
