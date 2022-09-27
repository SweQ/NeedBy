//
//  ChecksPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import UIKit
import CoreData

class ChecksPresenter: NSObject {
    weak var view: ChecksViewControllerProtocol?
    private let coreDataManager = CoreDataManager.share
    private var fetchController: NSFetchedResultsController<Check>!
    
    override init() {
        super.init()
        
        setupFetchController()
    }
    
    private func setupFetchController() {
        fetchController = coreDataManager.getFetchController(fetchRequest: Check.fetchRequest())
        try? fetchController.performFetch()
        fetchController.delegate = self
    }
}

//MARK: -ChecksPresenterProtocol
extension ChecksPresenter: ChecksPresenterProtocol  {
    func deleteCheck(at index: IndexPath) {
        let check = fetchController.object(at: index)
        check.prepareForDeletion()
        coreDataManager.deleteObject(object: check)
        coreDataManager.saveContext()
    }
    
    func getChecksCount() -> Int {
        return fetchController.fetchedObjects?.count ?? 0
    }
    
    func getChecksTitle(at index: IndexPath) -> String {
        
        let check = fetchController.object(at: index)
        return check.date ?? "-"
    }
    
    func openCheck(at index: IndexPath) {
        let check = fetchController.object(at: index)
        Coordinator.shared.goToCheckDetails(for: check)
    }
}

//MARK: -NSFetchedResultsControllerDelegate
extension ChecksPresenter: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return
            }
            view?.tableView?.insertRows(at: [newIndexPath], with: .bottom)
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            view?.tableView?.deleteRows(at: [indexPath], with: .bottom)
        case .move:
            guard let indexPath = indexPath,
                  let newIndexPath = newIndexPath
            else {
                return
            }
            view?.tableView?.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {
                return
            }
            view?.tableView?.reloadRows(at: [indexPath], with: .bottom)
        @unknown default:
            fatalError()
        }
    }
    
}
