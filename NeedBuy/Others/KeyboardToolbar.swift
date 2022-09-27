//
//  KeyboardToolbar.swift
//  NeedBuy
//
//  Created by alexKoro on 23.09.22.
//

import UIKit

class KeyboardToolbar: UIToolbar {

    lazy var actionButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(actionButtonPressed))
        return doneButton
    }()
    
    private var flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    private var actionButtonAction: (()->())?
    
    func configure(with title: String, action: (()->())?) {
        actionButton.title = title
        actionButtonAction = action
        self.setItems([flexibleSpace, actionButton], animated: true)
        self.frame.size.height = 36
    }
    
    @objc private func actionButtonPressed() {
        actionButtonAction?()
    }

}
