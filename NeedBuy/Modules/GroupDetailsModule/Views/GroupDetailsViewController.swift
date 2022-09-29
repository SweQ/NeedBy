//
//  GroupDetailsViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 13.09.22.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    
    var detailsView = BigTableView()
    var presenter: GroupDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailsView()
        setupTitle()
        setupAddButton()
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    //Всю логику добавления нужно перенести в ProductGroupsCreator!!!
    @objc private func addButtonPressed() {
        presenter?.addButtonPressed()
    }
    
    private func setupDetailsView() {
        view.addSubview(detailsView)
        detailsView.setupTotalConstraints(with: view)
        detailsView.tableView.register(ProductInBasketViewCell.self, forCellReuseIdentifier: ProductInBasketViewCell.identifier)
        detailsView.tableView.delegate = self
        detailsView.tableView.dataSource = self
        
    }
    
    private func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        title = presenter?.getTitle() ?? ""
    }

}

//MARK: -UITableViewDelegate and DataSource
extension GroupDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getComponentsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductInBasketViewCell.identifier) as? ProductInBasketViewCell
        else { return UITableViewCell() }
        
        if let productInBasket = presenter?.getProductInBasket(with: indexPath) {
            cell.config(with: productInBasket)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: Words.deleteTitle.value()) { [weak self] _, _, _ in
            self?.presenter?.removeProductFromGroup(with: indexPath)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.endUpdates()
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

//MARK: -GroupDetailsViewControllerProtocol
extension GroupDetailsViewController: GroupDetailsViewControllerProtocol {
    
}

//MARK: -BasketViewControllerProtocol
extension GroupDetailsViewController: BasketViewControllerProtocol {
    func addProductInBasket(productInBasket: ProductInBasket) {
        presenter?.addProductInBasket(productInBasket: productInBasket, tableView: detailsView.tableView)
    }
}
