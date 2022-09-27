//
//  CheckPriceTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import UIKit

class CheckPriceTableViewCell: UITableViewCell {
    
    static let identifier = "checkPriceTableViewCell"
    
    let totalInfoView = TotalInfoView()
    
    var totalPriceLabel: UILabel {
        return totalInfoView.totalCostLabel
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTotalInfoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTotalInfoView() {
        addSubview(totalInfoView)
        setupTotalInfoViewAnchors()
    }
    
    private func setupTotalInfoViewAnchors() {
        totalInfoView.setupTotalConstraints(with: self, constant: 10)
    }
    
}
