//
//  UIAlertAction+titleColor.swift
//  NeedBuy
//
//  Created by alexKoro on 15.09.22.
//

import Foundation
import UIKit

extension UIAlertAction {
    func setupTitleColor(_ color: UIColor) {
        setValue(color, forKey: "titleTextColor")
    }
}
