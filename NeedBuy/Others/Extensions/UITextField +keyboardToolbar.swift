//
//  UITextField +keyboardToolbar.swift
//  NeedBuy
//
//  Created by alexKoro on 23.09.22.
//

import Foundation
import UIKit

extension UITextField {
    func setupKeyboardToolbar(with title: String, action: @escaping ()->() ) {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.configure(with: title, action: action)
        self.inputAccessoryView = keyboardToolbar
    }
    
    func setupCancelToolbar() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.configure(with: "Cancel") { [weak self] in
            self?.resignFirstResponder()
        }
        self.inputAccessoryView = keyboardToolbar
    }
}
