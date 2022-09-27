//
//  MainViewPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import Foundation
import CoreData
import UIKit

protocol MainViewPresenterProtocol: NSObject {
    var fetchController: NSFetchedResultsController<Purchase>! {get set}
    var view: MainViewControllerProtocol? { get set}
    
    func addNewPurchaseButtonPressed()
    func deletePurchase(at index: IndexPath)
    func openPurchase(at index: IndexPath)
    func openProductList()
    func openChecksList()
    func openProductGroupsList()
    func makePurchase(at index: IndexPath)
    func menuBarButtonPressed()
}
