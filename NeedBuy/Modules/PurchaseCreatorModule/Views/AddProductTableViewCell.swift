//
//  AddProductTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 22.07.22.
//

import UIKit

class AddProductTableViewCell: UITableViewCell {

    let addButton = UIButton()
    
    static let identifier = "addProductButtonCell"
    
    func config() {
        setupAddButton()
    }
    
    private func setupAddButton() {
        //add button into contentView it's really important
        contentView.addSubview(addButton)
        
        addButton.setupStyleForPurchaseView(with: "Add product", textColor: .white)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        setupAddButtonConstraints()
    }
    
    private func setupAddButtonConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            addButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
}
