//
//  ProductGroupsCreatorViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//

import UIKit

class ProductGroupsCreatorViewController: UIViewController {
    
    var creatorView = ProductGroupsCreatorView()
    var presenter: GroupsCreatorPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupCreatorView()
        
        presenter?.showAlertForName(title: "Enter group name.", defaultValue: "New group")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            presenter?.cleareTemp()
        }
        
    }
    
    private func setupTitle() {
        title = "Product group creator."
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCreatorView() {
        view.addSubview(creatorView)
        creatorView.setupTotalConstraints(with: view)
        setupAddComponentButton()
        setupSaveButton()
        creatorView.tableView.delegate = self
        creatorView.tableView.dataSource = self
    }
    
    private func setupAddComponentButton() {
        creatorView.addComponentButton.addTarget(self, action: #selector(addComponentButtonPressed), for: .touchUpInside)
    }
    
    private func setupSaveButton() {
        creatorView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    @objc private func saveButtonPressed() {
        presenter?.saveButtonPressed()
    }
    
    @objc private func addComponentButtonPressed() {
        presenter?.addComponentButtonPressed()
    }
    
}

extension ProductGroupsCreatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountOfProductsInGroup() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        var config = cell.defaultContentConfiguration()
        config.text = presenter?.getCellTitle(at: indexPath)
        cell.contentConfiguration = config
        
        return cell
    }
    
    
}

extension ProductGroupsCreatorViewController: GroupsCreatorViewControllerProtocol {
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func changeTitle(title: String) {
        self.title = title
    }
}

extension ProductGroupsCreatorViewController: BasketViewControllerProtocol {
    func addProductInBasket(productInBasket: ProductInBasket) {
        presenter?.addProductInBasket(productInBasket: productInBasket, tableView: creatorView.tableView)
    }
    
    
}
