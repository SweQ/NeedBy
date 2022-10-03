//
//  CheckTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import UIKit

class CheckTableViewCell: UITableViewCell {
    
    static let identifier = "checkTableViewCell"
    
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDateLabel()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.applyTitleFont()
        setupDateLabelConstraints()
    }
    
    private func setupDateLabelConstraints() {
        dateLabel.setupTotalConstraints(with: self, constant: 10)
    }
    
}
