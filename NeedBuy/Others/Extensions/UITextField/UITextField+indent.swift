//
//  UITextField+indent.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit

extension UITextField {
    func indentLeft(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
    
    func indentRight(size: CGFloat) {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
        self.rightViewMode = .always
    }
}
