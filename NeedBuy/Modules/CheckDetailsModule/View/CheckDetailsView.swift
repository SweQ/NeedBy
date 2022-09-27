//
//  CheckDetailsView.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import UIKit

class CheckDetailsView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.separatorStyle = .none
        
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.setupTotalConstraints(with: self)
    }

}
