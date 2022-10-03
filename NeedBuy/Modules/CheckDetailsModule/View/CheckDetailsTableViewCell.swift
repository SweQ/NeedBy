//
//  CheckDetailsTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import UIKit

class CheckDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "checkDetailsTableViewCell"
    
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let totalCostLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNameLabel()
        setupCountLabel()
        setupTotalCostLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with purchasedProduct: PurchasedProduct) {
        guard let name = purchasedProduct.name else { return }
        let measure = purchasedProduct.getMeasureString()
        let count = purchasedProduct.count.shortString()
        let totalCost = purchasedProduct.totalCost.shortString()
        
        nameLabel.text = name
        countLabel.text = "\(count) \(measure)"
        totalCostLabel.text = totalCost
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.applyTitleFont()
        
        setupNameLabelAnchors()
    }
    
    private func setupNameLabelAnchors() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupCountLabel() {
        addSubview(countLabel)
        countLabel.textAlignment = .center
        countLabel.applyDescFont()
        setupCountLabelAnchors()
    }
    
    private func setupCountLabelAnchors() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            countLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10),
            countLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupTotalCostLabel() {
        addSubview(totalCostLabel)
        totalCostLabel.textAlignment = .right
        totalCostLabel.applyDescFont()
        setupTotalCostLabelAnchors()
    }
    
    private func setupTotalCostLabelAnchors() {
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalCostLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            totalCostLabel.leftAnchor.constraint(equalTo: countLabel.rightAnchor, constant: 10),
            totalCostLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            totalCostLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
    }
    
}
