//
//  UILabel + fonts.swift
//  NeedBuy
//
//  Created by alexKoro on 15.09.22.
//

import Foundation
import UIKit

extension UILabel {
    func applyTitleFont() {
        font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textColor = .label
    }
    
    func applyUsualFont() {
        font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textColor = .label
    }
    
    func applyDescFont() {
        font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textColor = .secondaryLabel
    }
    
    func applyCaptionFont() {
        font = UIFont.systemFont(ofSize: 13, weight: .regular)
        textColor = .secondaryLabel
    }
}
