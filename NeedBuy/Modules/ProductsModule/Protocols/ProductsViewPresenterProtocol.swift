//
//  ProductsViewPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import Foundation
import CoreData
import UIKit

protocol ProductsViewPresenterProtocol: NSObject {
    var fetchController: NSFetchedResultsController<Product>! { get set }
    var coreDataManager: CoreDataManager { get set }
    
    func delete(at index: IndexPath)
    func addProductInBasket(at index: IndexPath, count: Double, purchaseCreatorVC: PurchaseCreatorViewController, handler: (()->())? )
    func showProductEditor(with productIndex: IndexPath)
    func getProductMeasure(at index: IndexPath) -> String
    func getProduct(at index: IndexPath) -> Product
    func selectedProduct(at index: IndexPath)
}
