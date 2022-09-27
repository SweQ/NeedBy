//
//  UIViewController+setupTitle.swift
//  NeedBuy
//
//  Created by alexKoro on 14.09.22.
//

import Foundation
import UIKit

extension UIViewController {
    func setupTitle(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}
