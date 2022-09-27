//
//  ProductsViewPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 22.08.22.
//

import CoreData
import UIKit

class ProductsViewPresenter: NSObject, ProductsViewPresenterProtocol {

    var fetchController: NSFetchedResultsController<Product>!
    
    var coreDataManager = CoreDataManager.share
    var selectProductToBasketHandler: ((ProductInBasket) -> ())?
    
    weak var view: ProductsViewProtocol?
    
    
    override init() {
        super.init()
        setupFetchController()
    }
    
    private func setupFetchController() {
        fetchController = coreDataManager.getFetchController(fetchRequest: Product.fetchRequest())
        fetchController.delegate = self
        do {
            try fetchController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(at index: IndexPath) {
        let productForDelete = fetchController.object(at: index)
        let purchasesWithProduct = coreDataManager.getPurchases(with: productForDelete)
        let groupsWithProduct = coreDataManager.getGroups(with: productForDelete)
        
        if purchasesWithProduct.isEmpty && groupsWithProduct.isEmpty {
            productForDelete.prepareForDeletion()
            coreDataManager.viewContext.delete(productForDelete)
            coreDataManager.saveContext()
        } else {
            let errorString = createErrorMessage(
                with: purchasesWithProduct,
                groups: groupsWithProduct
            )
            let errorAlert = AlertCreator.shared.createErrorAlert(
                with: "Unable to delete!",
                message: errorString
            )
            view?.showAlertController(alert: errorAlert)
        }
    }
    
    private func createErrorMessage(with purchases: [Purchase], groups: [ProductsGroup]) -> String {
        var listOfPurchases = "Purchases: "
        var listOfGroups = "Groups: "
        
        purchases.forEach { purchase in
            if let purchaseTitle = purchase.title {
                listOfPurchases += " \(purchaseTitle),"
            }
        }
        listOfPurchases.removeLast()
        
        
        groups.forEach { group in
            if let groupName = group.name {
                listOfGroups += " \(groupName),"
            }
        }
        listOfGroups.removeLast()
        
         return "This product contains in:\n\(listOfPurchases)\n\(listOfGroups)"
    }
    
    func getProduct(at index: IndexPath) -> Product {
        let product = fetchController.object(at: index)
        return product
    }
    
    func addProductInBasket(at index: IndexPath,
                            count: Double,
                            purchaseCreatorVC: PurchaseCreatorViewController,
                            handler: (()->())?) {
        let product = fetchController.object(at: index)
        let productInBasket = self.coreDataManager.createProductInBasket(product: product, count: count)
        purchaseCreatorVC.addProductIntoBasket(productInBasket: productInBasket)
        handler?()
    }
    
    private func createAlertForCount(of product: Product, handler: @escaping (Double)->()) -> UIAlertController {
        
        let countTextField = UITextField()
        countTextField.placeholder = "Count..."
        
        let alertController = AlertCreator.shared.createAlertWithCancel(
            title: "Count of product, \(product.measure ?? Measure.pcs.rawValue)",
            message: nil,
            style: .alert,
            actions: [])
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter count of product..."
            textField.keyboardType = .decimalPad
        }
        
        let okAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let countString = alertController.textFields?.first?.text,
                  let count = countString.toDouble() else {
                return
            }
            handler(count)
        }
        alertController.addAction(okAction)
        
        return alertController
    }
    
    func getProductMeasure(at index: IndexPath) -> String {
        let product = fetchController.object(at: index)
        let productMeasure = product.measure ?? Measure.pcs.rawValue
        return productMeasure
    }
    
    func showProductEditor(with productIndex: IndexPath){
        let product = fetchController.object(at: productIndex)
        Coordinator.shared.goToProductCreatorController(with: product)
    }
    
    func selectedProduct(at index: IndexPath) {
        guard let previosVC = Coordinator.shared.previosViewController() else { return }
        
        if let basketViewController = previosVC as? BasketViewControllerProtocol {
            let product = fetchController.object(at: index)
            let alertForCountOfProduct = createAlertForCount(of: product) { [weak self] countOfProduct in
                guard let productInBasket = self?.coreDataManager.createProductInBasket(product: product, count: countOfProduct) else { return }
                basketViewController.addProductInBasket(productInBasket: productInBasket)
                Coordinator.shared.popViewController()
            }
            view?.showAlertController(alert: alertForCountOfProduct)
        } else {
            showProductEditor(with: index)
        }
    }
}

//MARK: -NSFetchedResultsControllerDelegate
extension ProductsViewPresenter: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.productsTable?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { return }
            view?.productsTable?.insertRows(at: [indexPath], with: .bottom)
        case .delete:
            guard let indexPath = indexPath else { return }
            view?.productsTable?.deleteRows(at: [indexPath], with: .bottom)
            
        case .move:
            guard let indexPath = indexPath,
                  let newIndexPath = newIndexPath
            else { return }
            view?.productsTable?.deleteRows(at: [indexPath], with: .bottom)
            view?.productsTable?.insertRows(at: [newIndexPath], with: .bottom)
        case .update:
            guard let indexPath = indexPath else { return }
            view?.productsTable?.reloadRows(at: [indexPath], with: .bottom)
            
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.productsTable?.endUpdates()
    }
}
