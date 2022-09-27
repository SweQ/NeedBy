//
//  ProductGroupsViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//

import UIKit

class ProductGroupsViewController: UIViewController {
    
    private let productGroupsView = BigTableView()
    private let productGroups = CoreDataManager.share.dowloadProductGroups()
    var presenter: ProductGroupsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupProductsGroupView()
        setupAddButton()
    }
    
    private func setupTitle() {
        setupTitle(title: "Product groups")
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    private func setupProductsGroupView() {
        view.addSubview(productGroupsView)
        productGroupsView.setupTotalConstraints(with: view)
        setupTableView()
    }
    
    private func setupTableView() {
        productGroupsView.tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.identifier)
        productGroupsView.tableView.delegate = self
        productGroupsView.tableView.dataSource = self
    }
    
//MARK: -Actions
    @objc private func addButtonPressed() {
        Coordinator.shared.goToProductGroupsCreatorController()
    }
}

//MARK: -TableViewDelegate and DataSource
extension ProductGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountOfProducts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroupTableViewCell.identifier
        ) as? GroupTableViewCell
        else { return UITableViewCell()}
        
        if let group = presenter?.getGroup(with: indexPath) {
            cell.config(with: group)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectGroup(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] _, _, _ in
            self?.presenter?.removeGroup(with: indexPath)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}

//MARK: -ProductGroupsViewControllerProtocol
extension ProductGroupsViewController: ProductGroupsViewControllerProtocol {
    var groupsTable: UITableView? {
        return productGroupsView.tableView
    }
}
