//
//  MainViewController + setupView.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import Foundation
import UIKit

extension MainViewController {
   func setupMainView() {
       view.addSubview(mainView)
       setupTableView()
       setupMainViewAnchors()
    }
    
    private func setupTableView() {
        mainView.tableView.register(PurchaseTableViewCell.self, forCellReuseIdentifier: PurchaseTableViewCell.identifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.separatorStyle = .none
    }
    
    func setupMainViewAnchors() {
        mainView.setupTotalConstraints(with: view)
    }
}
