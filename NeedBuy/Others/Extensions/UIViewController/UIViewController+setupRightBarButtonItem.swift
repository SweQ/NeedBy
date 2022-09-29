//
//  UIViewController+setupRightBarItem.swift
//  NeedBuy
//
//  Created by alexKoro on 21.07.22.
//

import UIKit

extension UIViewController {
    func setupRightBarButtonItem(
        systemItem: UIBarButtonItem.SystemItem,
        target: Any?,
        selector: Selector?,
        color: UIColor?
    ) {
        let item = createBarButtonItem(systemItem: systemItem, target: target, selector: selector, color: color)
        self.navigationItem.rightBarButtonItem = item
        
        
    }
    
    private func createBarButtonItem(
        systemItem: UIBarButtonItem.SystemItem,
        target: Any?,
        selector: Selector?,
        color: UIColor?
    ) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: systemItem, target: target, action: selector)
        item.tintColor = color ?? .black
        
        return item
    }
    
    
    func setupLeftBarButtonItem(
        systemItem: UIBarButtonItem.SystemItem,
        target: Any?,
        selector: Selector?,
        color: UIColor?
    ) {
        let item = createBarButtonItem(systemItem: systemItem, target: target, selector: selector, color: color)
        self.navigationItem.leftBarButtonItem = item
    }
}
