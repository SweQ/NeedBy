//
//  ProductGroupsPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 13.09.22.
//

import Foundation
import CoreData
import UIKit

class ProductGroupsPresenter: NSObject {
    
    weak var view: ProductGroupsViewControllerProtocol?
    private var fetchController: NSFetchedResultsController<ProductsGroup>!
    private let coordinator = Coordinator.shared
    private let dataManager = CoreDataManager.share
    
    override init() {
        super.init()
        setupFetchController()
    }
    
    private func setupFetchController() {
        self.fetchController = CoreDataManager.share.getFetchController(fetchRequest: ProductsGroup.fetchRequest())
        fetchController.delegate = self
        try? fetchController.performFetch()
    }
    
}

//MARK: -ProductGroupsPresenterProtocol
extension ProductGroupsPresenter: ProductGroupsPresenterProtocol {
    func showGroupDetails(at index: IndexPath) {
        let group = fetchController.object(at: index)
        coordinator.goToProductGroupDetailsController(with: group)
    }
    
    func getCountOfProducts() -> Int {
        return fetchController.sections?.first?.numberOfObjects ?? 0
    }
    
    func getGroup(with index: IndexPath) -> ProductsGroup {
        return fetchController.object(at: index)
    }
    
    func removeGroup(with index: IndexPath) {
        let group = fetchController.object(at: index)
        dataManager.deleteObject(object: group)
        dataManager.saveContext()
    }
    
    func selectGroup(at index: IndexPath) {
        guard let basketViewController = coordinator.previosViewController() as? BasketViewControllerProtocol else {
            showGroupDetails(at: index)
            return
        }
        
        let selectedGroup = fetchController.object(at: index)
        let productInBasket = selectedGroup.productsInBasket?.allObjects as? [ProductInBasket] ?? []
        productInBasket.forEach { productInBasket in
            basketViewController.addProductInBasket(productInBasket: productInBasket)
        }
        coordinator.popViewController()
    }
    
}

//MARK: -NSFetchedResultsControllerDelegate
extension ProductGroupsPresenter: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.groupsTable?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return
            }
            view?.groupsTable?.insertRows(at: [newIndexPath], with: .bottom)
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            view?.groupsTable?.deleteRows(at: [indexPath], with: .bottom)
        case .move:
            if let indexPath = indexPath,
               let newIndexPath = newIndexPath {
                view?.groupsTable?.deleteRows(at: [indexPath], with: .bottom)
                view?.groupsTable?.insertRows(at: [newIndexPath], with: .bottom)
            }
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        view?.groupsTable?.endUpdates()
    }
}
