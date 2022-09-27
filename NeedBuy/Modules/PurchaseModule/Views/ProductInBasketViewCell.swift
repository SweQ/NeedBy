//
//  ProductViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit

class ProductInBasketViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let costLabel = UILabel()
    
    static let identifier = "productInBasketCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with produсtInBasket: ProductInBasket) {
        fillLabels(with: produсtInBasket)
    }
    
    private func fillLabels(with productInBasket: ProductInBasket) {
        guard let name = productInBasket.product?.name,
              let measure = productInBasket.product?.measure
        else { return }
        nameLabel.text = name
        costLabel.text = "price: \(productInBasket.getCost().shortString())"
        countLabel.text = "\(productInBasket.count.shortString()) \(measure)"
    }
    
    private func setupLabels() {
        setupNameLabel()
        setupCostLabel()
        setupCountLabel()
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        setupNameLabelAnchors()
        nameLabel.applyUsualFont()
    }
    
    private func setupNameLabelAnchors() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupCountLabel() {
        addSubview(countLabel)
        setupCountLabelAnchors()
        countLabel.applyDescFont()
    }
    
    private func setupCountLabelAnchors() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            countLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countLabel.leftAnchor.constraint(greaterThanOrEqualTo: nameLabel.rightAnchor, constant: 10),
            countLabel.rightAnchor.constraint(lessThanOrEqualTo: costLabel.leftAnchor, constant: -10)
        ])
    }
    
    private func setupCostLabel() {
        addSubview(costLabel)
        setupCostLabelAnchors()
        costLabel.applyDescFont()
    }
    
    private func setupCostLabelAnchors() {
        
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            costLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            costLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
        
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        costLabel.text = nil
        countLabel.text = nil
    }

}
