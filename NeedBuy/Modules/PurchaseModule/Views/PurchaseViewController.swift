//
//  PurchaseViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit
import CoreData

class PurchaseViewController: UIViewController {
    
    let purchaseView = PurchaseView()
    var presenter: PurchasePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPurchaseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBar()
    }
    
    private func setupBar() {
        
        if let title = presenter?.createTitleString() {
            setupTitle(title: title)
        }
        
        navigationController?.navigationBar.tintColor = .black
        
        setupRightBarButtonItem(
            systemItem: .add,
            target: self,
            selector: #selector(addBarButtonPressed),
            color: .black
        )
    }
    
    private func setupTableView() {
        purchaseView.tableView.register(ProductInBasketViewCell.self, forCellReuseIdentifier: ProductInBasketViewCell.identifier)
        purchaseView.tableView.delegate = self
        purchaseView.tableView.dataSource = self
    }
    
    private func setupPurchaseView() {
        view.addSubview(purchaseView)
        purchaseView.translatesAutoresizingMaskIntoConstraints = false
        purchaseView.setupTotalConstraints(with: view)
        presenter?.setupTotalPrice()
    }
    
    @objc private func addBarButtonPressed() {
        presenter?.addProductButtonPressed()
    }
    
}

//MARK: -UITableViewDelegate and DataSource
extension PurchaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountOfProducts() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(
            withIdentifier: ProductInBasketViewCell.identifier
        ) as? ProductInBasketViewCell else {
            return UITableViewCell()
        }
        
        if let productInBasket = presenter?.getProductInBasket(at: indexPath) {
            productCell.config(with: productInBasket)
        }
        
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectProductInBasket(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] _, _, _ in
            self?.presenter?.removeProductFromBasket(at: indexPath)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Buy") { [weak self] _, _, _ in
            self?.presenter?.purchaseProductButtonPressed(at: indexPath)
        }
        doneAction.backgroundColor = .green
        let config = UISwipeActionsConfiguration(actions: [doneAction])
        
        return config
    }
    
}

//MARK: -PurchaseViewControllerProtocol
extension PurchaseViewController: PurchaseViewControllerProtocol {
    var purchasesTable: UITableView? {
        return purchaseView.tableView
    }
    
    func showAlertController(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func updateTotalCost(with totalCost: String) {
        purchaseView.totalInfoView.totalCostLabel.text = totalCost
    }
}

//MARK: -BasketViewControllerProtocol
extension PurchaseViewController: BasketViewControllerProtocol {
    func addProductInBasket(productInBasket: ProductInBasket) {
        presenter?.addProductInBasket(newProductInBasket: productInBasket)
    }
}
