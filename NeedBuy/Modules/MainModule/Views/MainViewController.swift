//
//  MainViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var mainView = BigTableView()
    var presenter: MainViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupBar()
    }
    
    private func setupBar() {
        setupTitle(title: "Planning purchases")
        setupBarItems()
    }
    
    private func setupBarItems() {
        setupRightBarButtonItem(
            systemItem: .add,
            target: self,
            selector: #selector(addBarButtonPressed),
            color: .black
        )
        
        setupLeftBarButtonItem(
            systemItem: .organize,
            target: self
            , selector: #selector(menuBarButtonPressed),
            color: .black
        )
    }
    
    //MARK: --Actions
    @objc func addBarButtonPressed() {
        presenter?.addNewPurchaseButtonPressed()
    }
    
    @objc func menuBarButtonPressed() {
        presenter?.menuBarButtonPressed()
    }
}

//MARK: --MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func beginUpdateTable() {
        mainView.tableView.beginUpdates()
    }
    
    func insertRowsInTable(at indexes: [IndexPath]) {
        mainView.tableView.insertRows(at: indexes, with: .fade)
    }
    
    func deleteRowsInTable(at indexes: [IndexPath]) {
        mainView.tableView.deleteRows(at: indexes, with: .fade)
    }
    
    func updateRowInTable(at index: IndexPath, purchase: Purchase) {
        if let cell = mainView.tableView.cellForRow(at: index) as? PurchaseTableViewCell {
            cell.config(purchase: purchase)
        }
    }
    
    func endUpdateTable() {
        mainView.tableView.endUpdates()
    }

}

//MARK: -UITableViewDelegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = presenter?.fetchController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let purchaseCell = tableView.dequeueReusableCell(
            withIdentifier: PurchaseTableViewCell.identifier
        ) as? PurchaseTableViewCell else {
            return UITableViewCell()
        }
        
        if let purchase = presenter?.fetchController.object(at: indexPath) {
            purchaseCell.config(purchase: purchase)
        }

        return purchaseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openPurchase(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] _, view, _ in
            self?.presenter?.deletePurchase(at: indexPath)
        }
  
        let deleteConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return deleteConfig
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { [weak self] _, _, _ in
            self?.presenter?.makePurchase(at: indexPath)
        }
        doneAction.backgroundColor = .green
        
        let doneConfig = UISwipeActionsConfiguration(actions: [doneAction])
        
        return doneConfig
    }
    
}
