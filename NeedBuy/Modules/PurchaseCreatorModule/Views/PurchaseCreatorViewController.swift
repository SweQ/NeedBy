//
//  PurchaseCreatorViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 21.07.22.
//

import UIKit

class PurchaseCreatorViewController: UIViewController {

    let purchaseCreatorView = PurchaseCreatorView()
    var presenter: PurchaseCreatorPresenterProtocol?
    
    var stepViews: [UIView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.showPurchaseTitleAlert()
    }
    
    private func setupHiddenPropertyToNextButton(isHidden: Bool) {
        purchaseCreatorView.nextButton.isHidden = isHidden
        purchaseCreatorView.createButton.isHidden = !isHidden
    }
    
    private func setup() {
        view.backgroundColor = .white
        setupTitle(title: "Creating new purchase.")
        setupPurchaseCreatorView()
        
        stepViews = [
            purchaseCreatorView.datePicker,
            purchaseCreatorView.tableView
        ]
    }
    
    func setupButtons() {
        purchaseCreatorView.createButton.addTarget(self, action: #selector(createButtonPressed(sender:)), for: .touchUpInside)
        purchaseCreatorView.nextButton.addTarget(self, action: #selector(nextButtonPressed(sender:)), for: .touchUpInside)
        purchaseCreatorView.backButton.addTarget(self, action: #selector(backButtonPressed(sender:)), for: .touchUpInside)
    }
    
    private func showErrorZeroProductsAlert() {
        let alert = AlertCreator.shared.createErrorAlert(
            with: "Warning",
            message: "Basket have 0 products.\nPlease, add products into basket."
        )
        present(alert, animated: true)
    }
    
    private func setupVisibleBackButton(with index: Int){
        if index == 0 {
            purchaseCreatorView.backButton.isHidden = true
        } else {
            purchaseCreatorView.backButton.isHidden = false
        }
    }
    
    private func setupVisibleNextButton(with index: Int) {
        if index == stepViews.count - 1 {
            setupHiddenPropertyToNextButton(isHidden: true)
        } else {
            setupHiddenPropertyToNextButton(isHidden: false)
        }
    }
    
    @objc private func createButtonPressed(sender: UIButton) {
        guard let countProductsInBasket = presenter?.getCountOfProductsInBasket(),
              countProductsInBasket > 0 else {
            showErrorZeroProductsAlert()
            return
        }
        
        presenter?.createPurchase(
            with: purchaseCreatorView.datePicker.date
        )
    }
    
    @objc private func backButtonPressed(sender: UIButton) {
        if stepViews.first?.isHidden == false {
            //closeThisView()
        }
        presenter?.previosStep(with: stepViews.count)
    }
    
    @objc private func nextButtonPressed(sender: UIButton) {
        presenter?.nextStep(with: stepViews.count)
    }
    
    @objc private func addProductButtonPressed(sender: UIButton) {
        presenter?.addButtonPressed()
    }
}

//MARK: -UITableViewDelegate and UITableViewDataSource
extension PurchaseCreatorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter?.getCountOfProductsInBasket() ?? 0
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] _, _, _ in
            self?.presenter?.removeProductFromBasket(at: indexPath)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductInBasketViewCell.identifier
            ) as? ProductInBasketViewCell,
                  let presenter = presenter
            else { return UITableViewCell() }
            
            cell.config(with: presenter.getProductInBasket(with: indexPath))
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddProductTableViewCell.identifier
            ) as? AddProductTableViewCell else {
                return UITableViewCell()
            }
            
            setupAddProductTableViewCell(cell: cell)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func setupAddProductTableViewCell(cell: AddProductTableViewCell) {
        cell.config()
        cell.addButton.addTarget(self, action: #selector(addProductButtonPressed), for: .touchUpInside)
    }
}

//MARK: -PurchaseCreatorViewProtocol
extension PurchaseCreatorViewController: PurchaseCreatorViewProtocol {
    
    var productsTable: UITableView? {
        return purchaseCreatorView.tableView
    }
    
    func showStepView(with index: Int) {
        setupVisibleBackButton(with: index)
        setupVisibleNextButton(with: index)
        stepViews[index].isHidden = false
    }
    
    func hideStepView(with index: Int) {
        stepViews[index].isHidden = true
    }
    
    func showVC(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func addProductIntoBasket(productInBasket: ProductInBasket) {
        presenter?.addProductInBasket(productInBasket: productInBasket)
    }
}

//MARK: -BasketViewControllerProtocol
extension PurchaseCreatorViewController: BasketViewControllerProtocol {
    func addProductInBasket(productInBasket: ProductInBasket) {
        presenter?.addProductInBasket(productInBasket: productInBasket)
    }
}
