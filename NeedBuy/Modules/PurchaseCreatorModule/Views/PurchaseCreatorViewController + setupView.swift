//
//  PurchaseCreatorViewController + setupView.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import Foundation
import UIKit

extension PurchaseCreatorViewController {
    func setupPurchaseCreatorView() {
        view.addSubview(purchaseCreatorView)
        
        setupButtons()
        purchaseCreatorView.tableView.delegate = self
        purchaseCreatorView.tableView.dataSource = self
        purchaseCreatorView.translatesAutoresizingMaskIntoConstraints = false
        
        setupPurchaseCreatorViewConstraints()
    }
    
    private func setupPurchaseCreatorViewConstraints() {
        NSLayoutConstraint.activate([
            purchaseCreatorView.topAnchor.constraint(equalTo: view.topAnchor),
            purchaseCreatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            purchaseCreatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            purchaseCreatorView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    
    
}
