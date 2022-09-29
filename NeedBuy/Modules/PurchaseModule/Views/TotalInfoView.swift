//
//  TotalInfoView.swift
//  NeedBuy
//
//  Created by alexKoro on 15.09.22.
//

import UIKit

class TotalInfoView: UIView {
    
    private var titleLabel = UILabel()
    var totalCostLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupTitleLabel()
        setupTotalCostLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textAlignment = .left
        titleLabel.text = "\(Words.totalPriceTitle.value()):"
        titleLabel.applyTitleFont()
        setupTitleLabelAnchors()
    }
    
    private func setupTitleLabelAnchors() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    private func setupTotalCostLabel() {
        addSubview(totalCostLabel)
        totalCostLabel.textAlignment = .right
        totalCostLabel.applyUsualFont()
        setupTotalCostLabelAnchors()
    }
    
    private func setupTotalCostLabelAnchors() {
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalCostLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            totalCostLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            totalCostLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            totalCostLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10),
            totalCostLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1)
        ])
    }
    
}
