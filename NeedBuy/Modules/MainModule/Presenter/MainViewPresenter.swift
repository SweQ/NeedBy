//
//  MainViewPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import Foundation
import CoreData
import UIKit

class MainViewPresenter: NSObject {
    
    var fetchController: NSFetchedResultsController<Purchase>!
    
    private let coreManager = CoreDataManager.share
    private let coordinator = Coordinator.shared
    private let purchaseManager = PurchaseManager.share
    
    weak var view: MainViewControllerProtocol?
    
    override init() {
        super.init()
        setupFetchController()
    }
    
    private func setupFetchController() {
        fetchController = coreManager.getFetchController(fetchRequest: Purchase.fetchRequest())
        fetchController.delegate = self
        do {
            try fetchController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createMenuAlert() -> UIAlertController {
        let showProductsAction = UIAlertAction(title: Words.productsTitle.value(), style: .default) { [weak self] _ in
            self?.openProductList()
        }
        
        let showCheksAction = UIAlertAction(title: Words.checksTitle.value(), style: .default) { [weak self] _ in
            self?.openChecksList()
        }
        
        let showProductGroups = UIAlertAction(title: Words.productGroupsTitle.value(), style: .default) { [weak self] _ in
            self?.openProductGroupsList()
        }
        
        showProductsAction.setupTitleColor(.darkGray)
        showCheksAction.setupTitleColor(.darkGray)
        showProductGroups.setupTitleColor(.darkGray)
        
        let menuAlert = AlertCreator.shared.createAlertWithCancel(
            title: Words.menuTitle.value(),
            message: nil,
            style: .actionSheet,
            actions: [showProductsAction, showProductGroups,showCheksAction]
        )
        
        return menuAlert
    }
    
}

//MARK: --MainViewPresenterProtocol
extension MainViewPresenter: MainViewPresenterProtocol {
    func addNewPurchaseButtonPressed() {
        coordinator.goToPurchaseCreatorController()
    }
    
    func deletePurchase(at index: IndexPath) {
        let purchase = fetchController.object(at: index)
        NotificationsCenter.shared.removeNotification(for: purchase)
        coreManager.viewContext.delete(purchase)
        coreManager.saveContext()
    }
    
    func openChecksList() {
        coordinator.goToChecksController()
    }
    
    func openPurchase(at index: IndexPath) {
        let purchase = fetchController.object(at: index)
        coordinator.goToPurchaseController(with: purchase)
    }
    
    func openProductGroupsList() {
        coordinator.goToProductGroupsController()
    }
    
    func openProductList() {
        coordinator.goToProductsController()
    }
    
    func makePurchase(at index: IndexPath) {
        let purchase = fetchController.object(at: index)
        purchaseManager.purchaseAllComponents(in: purchase)
        deletePurchase(at: index)
    }
    
    func menuBarButtonPressed() {
        let alert = createMenuAlert()
        view?.presentAlert(alert: alert)
    }
}

//MARK: --NSFetchedResultsControllerDelegate
extension MainViewPresenter: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.beginUpdateTable()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                view?.insertRowsInTable(at: [newIndexPath])
            }
        case .delete:
            if let indexPath = indexPath {
                view?.deleteRowsInTable(at: [indexPath])
            }
        case .move:
            if let indexPath = indexPath,
               let newIndexPath = newIndexPath {
                view?.deleteRowsInTable(at: [indexPath])
                view?.insertRowsInTable(at: [newIndexPath])
            }
        case .update:
            if let indexPath = indexPath {
                let purchase = fetchController.object(at: indexPath)
                view?.updateRowInTable(at: indexPath, purchase: purchase)
            }
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.endUpdateTable()
    }
}
