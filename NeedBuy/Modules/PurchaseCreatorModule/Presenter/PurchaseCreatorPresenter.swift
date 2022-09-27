//
//  PurchaseCreatorPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import Foundation
import UIKit

class PurchaseCreatorPresenter: NSObject {
    
    let coreDataManager = CoreDataManager.share
    weak var view: PurchaseCreatorViewProtocol?
    private let coordinator = Coordinator.shared
    private var purchaseTitle: String!
    
    var productsInBasket: [ProductInBasket] = [] {
        didSet {
            view?.productsTable?.reloadData()
        }
    }
    
    private var stepsCount: Int = 0
    
    private var step = 0 {
        didSet {
            if step > (stepsCount - 1) {
                step = stepsCount - 1
            } else if step < 0 {
                step = 0
            } else {
                view?.showStepView(with: step)
                view?.hideStepView(with: oldValue)
            }
        }
    }

    private func showProductGroupsList() {
        coordinator.goToProductGroupsController()
    }
    
    private func showProductsList() {
        coordinator.goToProductsController()
    }
    
    private func setupPurchaseTitle(title: String) {
        if title.isEmpty {
            showIncorrectTitleAlert(with: "Purchase must has name.")
        } else if !coreDataManager.isPurchaseTitleFree(title: title) {
            showIncorrectTitleAlert(with: "This title already exists.")
        } else {
            purchaseTitle = title
        }
    }
    
    private func showIncorrectTitleAlert(with reason: String) {
        let incorrectTitleAllert = AlertCreator.shared.createErrorAlert(with: "Title error!", message: reason) { [weak self] in
            self?.showPurchaseTitleAlert()
        }
        view?.showAlert(alert: incorrectTitleAllert)
    }
    

    

    
    
}

//MARK: -PurchaseCreatorPresenterProtocol
extension PurchaseCreatorPresenter: PurchaseCreatorPresenterProtocol {
    
    func createPurchase(with date: Date) {
        
        let purchase = coreDataManager.createPurchase(
            date: date,
            title: purchaseTitle,
            productsInBasket: productsInBasket
        )
        coreDataManager.saveContext()
        Coordinator.shared.popViewController()
        NotificationsCenter.shared.addNotification(with: purchase)
    }
    
    func showPurchaseTitleAlert() {
        let titleAlert = AlertCreator.shared.createAlertWithCancel(title: "Purchase name", message: nil, style: .alert, actions: []) {
            Coordinator.shared.popViewController()
        }
        titleAlert.addTextField { textField in
            textField.placeholder = "Enter purchase name..."
        }
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let purchaseName = titleAlert.textFields?.first?.text else { return }
            self?.setupPurchaseTitle(title: purchaseName)
        }
        titleAlert.addAction(okAction)
        
        view?.showAlert(alert: titleAlert)
    }
    
    func getCountOfProductsInBasket() -> Int {
        return productsInBasket.count
    }
    
    func removeProductFromBasket(at index: IndexPath) {
        productsInBasket.remove(at: index.row)
    }
    
    func nextStep(with stepsCount: Int) {
        self.stepsCount = stepsCount
        step += 1
    }
    
    func previosStep(with stepsCount: Int) {
        self.stepsCount = stepsCount
        step -= 1
    }
    
    func addProductInBasket(productInBasket: ProductInBasket) {
        if let indexOfSameEntry = productsInBasket.firstIndex(where: { p in
            p.product?.name == productInBasket.product?.name
        }) {
            view?.productsTable?.beginUpdates()
            productsInBasket[indexOfSameEntry].count += productInBasket.count
            let index = IndexPath(row: indexOfSameEntry, section: 0)
            view?.productsTable?.reloadRows(at: [index], with: .bottom)
            view?.productsTable?.endUpdates()
        } else {
            productsInBasket.append(productInBasket)
        }
    }
    
    func getProductInBasket(with index: IndexPath) -> ProductInBasket {
        return productsInBasket[index.row]
    }
    
    func addButtonPressed() {
        let productsSource = UIAlertAction(
            title: "Products",
            style: .default
        ) {[weak self] _ in
            self?.showProductsList()
        }
        let productGroupsSource = UIAlertAction(
            title: "Product groups",
            style: .default
        ) { [weak self] _ in
            self?.showProductGroupsList()
        }
        let sourceAlert = AlertCreator.shared.createAlertWithCancel(
            title: "Source",
            message: nil,
            style: .actionSheet,
            actions: [productsSource, productGroupsSource])
        view?.showAlert(alert: sourceAlert)
    }
    
    
}

