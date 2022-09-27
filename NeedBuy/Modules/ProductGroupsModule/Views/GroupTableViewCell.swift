//
//  GroupTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 19.09.22.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    static let identifier = "groupTableViewCell"
    
    var nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNameLabel()
        setupAccessoryType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAccessoryType() {
        if Coordinator.shared.previosViewController() is BasketViewControllerProtocol {
            accessoryType = .none
        } else {
            accessoryType = .disclosureIndicator
        }
    }
    
    func config(with group: ProductsGroup) {
        let name = group.name ?? "-"
        nameLabel.text = name
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.applyTitleFont()
        nameLabel.textAlignment = .left
        setupNameLabelAnchors()
    }
    
    private func setupNameLabelAnchors() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.setupTotalConstraints(with: self, constant: 10)
    }
    
}
