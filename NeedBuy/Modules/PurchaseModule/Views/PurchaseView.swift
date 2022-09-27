//
//  PurchaseView.swift
//  NeedBuy
//
//  Created by alexKoro on 6.09.22.
//

import UIKit

class PurchaseView: UIView {
    
    let tableView = UITableView()
    let totalInfoView = TotalInfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupTotalInfoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        setupTableViewAnchors()
    }
    
    private func setupTableViewAnchors() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9)
        ])
    }
    
    private func setupTotalInfoView() {
        addSubview(totalInfoView)
        setupTotalInfoViewAnchors()
    }
    
    private func setupTotalInfoViewAnchors() {
        totalInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalInfoView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            totalInfoView.leftAnchor.constraint(equalTo: tableView.leftAnchor),
            totalInfoView.rightAnchor.constraint(equalTo: tableView.rightAnchor),
            totalInfoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
