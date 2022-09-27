//
//  ProductsViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit
import CoreData

class ProductsViewController: UIViewController {
    
    let productsView = BigTableView()
    var presenter: ProductsViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBar()
        setupProductsView()
    }
    
    private func setupBar() {
        setupTitle(title: "Products")
    
        setupRightBarButtonItem(
            systemItem: .add,
            target: self,
            selector: #selector(addBatButtonPressed),
            color: .black
        )
    }
    
    @objc private func addBatButtonPressed() {
        Coordinator.shared.goToProductCreatorController(with: nil)
    }
    
    private func setupProductsView() {
        view.addSubview(productsView)
        
        productsView.translatesAutoresizingMaskIntoConstraints = false
        productsView.setupAnchors(with: view)
        
        productsView.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productCell")
        productsView.tableView.delegate = self
        productsView.tableView.dataSource = self
    }

}

//MARK: -ProductsViewProtocol
extension ProductsViewController: ProductsViewProtocol {
    var productsTable: UITableView? {
        return productsView.tableView
    }
    
    func showAlertController(alert: UIAlertController) {
        present(alert, animated: true)
    }
}

//MARK: -UITableViewDelegate and DataSource
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = presenter?.fetchController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.identifier
        ) as? ProductTableViewCell
        else {
            return UITableViewCell()
        }
        
        if let product = presenter?.getProduct(at: indexPath) {
            productCell.config(with: product)
        }
        
        return productCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self ] action, view, complete in
            self?.presenter?.delete(at: indexPath)
            complete(true)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedProduct(at: indexPath)
    }
}
