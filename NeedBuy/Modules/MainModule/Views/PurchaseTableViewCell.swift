//
//  PurchaseTableViewCell.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {
    
    static let identifier = "purchaseCell"
    
    var containerView = UIView()
    var dateLabel = UILabel()
    var titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContainerView()
        setupTitleLabel()
        setupDateLabel()
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 0.2
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.backgroundColor = .white
        setupContainerViewAnchors()
        setupShadow()
    }
    
    private func setupShadow() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 2
    }
    
    private func setupContainerViewAnchors() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5)
        ])
    }
    
    func config(purchase: Purchase) {
        dateLabel.text = "Planning date: \(purchase.getStringDate())"
        titleLabel.text = purchase.getTitle()
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.textAlignment = .left
        dateLabel.applyDescFont()
        setupDateLabelAnchors()
    }
    
    private func setupDateLabelAnchors() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.applyTitleFont()
        titleLabel.textAlignment = .left
        setupTitleLabelAnchors()
    }
    
    private func setupTitleLabelAnchors() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5),
        ])
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        titleLabel.text = nil
    }

}
