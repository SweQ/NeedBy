//
//  ProductTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "productCell"
    
    let productImageView = RoundImageView(image: nil)
    let nameLabel = UILabel()
    let costLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProductImageView()
        setupNameLabel()
        setupCostLabel()
        setupAccessoryType()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupAccessoryType() {
        if Coordinator.shared.previosViewController() is BasketViewControllerProtocol {
            accessoryType = .none
        } else {
            accessoryType = .disclosureIndicator
        }
    }

    private func setupProductImageView() {
        self.addSubview(productImageView)
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),
        ])
    }
    
    private func setupNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.applyTitleFont()
        setupNameLabelConstraints()
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10)
        ])
    }
    
    private func setupCostLabel() {
        addSubview(costLabel)
        costLabel.applyDescFont()
        setupCostLabelConstraints()
    }
    
    private func setupCostLabelConstraints() {
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            costLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            costLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            costLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -5),
            costLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func config(with product: Product) {

        let productName = product.name ?? "-"
        let productPrice = product.cost.shortString()
        let productMeasure = product.getMeasureString()
        productImageView.image = product.image
        nameLabel.text = productName
        costLabel.text = "\(Words.priceTitle.value()): \(productPrice) \(Words.per1.value()) \(productMeasure)"
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        productImageView.image = nil
        costLabel.text = nil
    }

}
