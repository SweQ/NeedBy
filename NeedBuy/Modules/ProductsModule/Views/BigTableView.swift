//
//  ProductsView.swift
//  NeedBuy
//
//  Created by alexKoro on 22.08.22.
//

import UIKit

class BigTableView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        setupTableViewAnchors()
    }
    
    func setupAnchors(with containerView: UIView) {
        self.setupTotalConstraints(with: containerView)
    }
    
    private func setupTableViewAnchors() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    
}
