//
//  PurchasePresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 6.09.22.
//

import Foundation
import UIKit
import CoreData

class PurchasePresenter: NSObject {
    
    weak var view: PurchaseViewControllerProtocol?
    
    private var coreManager = CoreDataManager.share
    private var purchaseManager = PurchaseManager.share
    private var fetchController: NSFetchedResultsController<ProductInBasket>!
    
    var purchase: Purchase
    
    init(purchase: Purchase) {
        self.purchase = purchase
        super.init()
        setupFetchController()
    }
    
    private func setupFetchController() {
        fetchController = coreManager.getPurchaseFetchController(with: purchase.getTitle(), fetchRequest: ProductInBasket.fetchRequest())
        fetchController.delegate = self
        try? fetchController.performFetch()
    }
    
    private func addNewProductToBasket(productInBasket: ProductInBasket) {
        purchase.addToProductsInBasket(productInBasket)
        coreManager.saveContext()
    }
    
    private func createMenuAlert(with indexPath: IndexPath) -> UIAlertController {
        let productInBasket = fetchController.object(at: indexPath)
        let productName = productInBasket.product?.name ?? "-"
        let buyAction = UIAlertAction(title: Words.buyTitle.value(), style: .default) { [weak self] _ in
            self?.purchase(productInBasket: productInBasket)
        }
        let deleteAction = UIAlertAction(title: Words.deleteTitle.value(), style: .destructive) { [weak self] _ in
            self?.removeProductFromBasket(at: indexPath)
        }
        let editCountAction = UIAlertAction(title: Words.editTitle.value(), style: .default) { [weak self] _ in
            guard let editAlert = self?.createCountEditorAlert(for: productInBasket) else { return }
            self?.view?.showAlertController(alert: editAlert)
        }
        buyAction.setupTitleColor(.darkGray)
        editCountAction.setupTitleColor(.darkGray)
        
        let menuAlert = AlertCreator.shared.createAlertWithCancel(title: "\(Words.selectActionFor.value()) \(productName)", message:nil, style: .actionSheet, actions: [buyAction, editCountAction, deleteAction])
        
        return menuAlert
        
    }
    
    private func showCountEditor(for productInBasket: ProductInBasket) {
        let countEditorAlert = createCountEditorAlert(for: productInBasket)
        view?.showAlertController(alert: countEditorAlert)
    }
    
    private func createCountEditorAlert(for productInBasket: ProductInBasket) -> UIAlertController {
        let measure = productInBasket.product?.getMeasureString() ?? Measure.pcs.rawValue
        let currentCount = productInBasket.count
        let alert = AlertCreator.shared.createAlertWithCancel(title: "\(Words.enterCount.value()), \(measure)", message: nil, style: .alert, actions: [])
        alert.addTextField { countTF in
            countTF.text = "\(currentCount)"
            countTF.keyboardType = .decimalPad
        }
        let saveAction = UIAlertAction(title: Words.saveTitle.value(), style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text,
                  let newValue = text.toDouble()
            else { return }
            
            self?.changeCount(for: productInBasket, newValue: newValue)
        }
        saveAction.setupTitleColor(.darkGray)
        alert.addAction(saveAction)
        
        return alert
    }
    
    private func changeCount(for productInBasket: ProductInBasket, newValue: Double) {
        productInBasket.count = newValue
        coreManager.saveContext()
    }
    
    private func purchase(productInBasket: ProductInBasket) {
        purchaseManager.purchaseProduct(productInBasket: productInBasket)
        purchase.removeFromProductsInBasket(productInBasket)
        coreManager.viewContext.delete(productInBasket)
        coreManager.saveContext()
    }
}

//MARK: -PurchasePresenterProtocol
extension PurchasePresenter: PurchasePresenterProtocol {
    func createTitleString() -> String {
        let title = purchase.getTitle()
        return title
    }
    
    func addProductInBasket(newProductInBasket: ProductInBasket) {
        
        if let sameProduct = fetchController.fetchedObjects?.first(where: { p in
            p.product?.name == newProductInBasket.product?.name
        }) {
            sameProduct.count += newProductInBasket.count
            coreManager.saveContext()
        } else {
            addNewProductToBasket(productInBasket: newProductInBasket)
        }
    }
    
    func addProductButtonPressed() {
        let productsSource = UIAlertAction(
            title: Words.productsTitle.value(),
            style: .default
        ) { _ in
            Coordinator.shared.goToProductsController()
        }
        productsSource.setupTitleColor(.darkGray)
        let productGroupsSource = UIAlertAction(
            title: Words.productGroupsTitle.value(),
            style: .default
        ) { _ in
            Coordinator.shared.goToProductGroupsController()
        }
        productGroupsSource.setupTitleColor(.darkGray)
        let sourceAlert = AlertCreator.shared.createAlertWithCancel(
            title: Words.sourceTitle.value(),
            message: nil,
            style: .actionSheet,
            actions: [productsSource, productGroupsSource])
        view?.showAlertController(alert: sourceAlert)
    }
    
    func selectProductInBasket(at index: IndexPath) {
        let menuAlert = createMenuAlert(with: index)
        view?.showAlertController(alert: menuAlert)
    }
    
    func getCountOfProducts() -> Int {
        return purchase.getProductCount()
    }
    
    func setupTotalPrice() {
        let totalPrice = purchase.getCost()
        view?.updateTotalCost(with: totalPrice.shortString())
    }
    
    func purchaseProductButtonPressed(at index: IndexPath) {
        let productInBasket = fetchController.object(at: index)
        purchase(productInBasket: productInBasket)
    }
    
    func setupCell(cell: ProductInBasketViewCell, index: IndexPath) {
        guard let productInBasket = getProductInBasket(at: index) else { return }
        cell.config(with: productInBasket)
    }
    
    func removeProductFromBasket(at index: IndexPath) {
        let productInBasket = fetchController.object(at: index)
        coreManager.viewContext.delete(productInBasket)
        coreManager.saveContext()
    }
    
    func getProductInBasket(at index: IndexPath) -> ProductInBasket? {
        return fetchController.object(at: index)
    }
}

//MARK: -NSFetchedResultsControllerDelegate
extension PurchasePresenter: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.purchasesTable?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        setupTotalPrice()
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return
            }
            view?.purchasesTable?.insertRows(at: [newIndexPath], with: .bottom)
            
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            view?.purchasesTable?.deleteRows(at: [indexPath], with: .bottom)
            
        case .move:
            if let indexPath = indexPath,
               let newIndexPath = newIndexPath {
                view?.purchasesTable?.deleteRows(at: [indexPath], with: .bottom)
                view?.purchasesTable?.insertRows(at: [newIndexPath], with: .bottom)
            }
        case .update:
            guard let indexPath = indexPath else {
                return
            }
            view?.purchasesTable?.reloadRows(at: [indexPath], with: .bottom)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.purchasesTable?.endUpdates()
    }
}
