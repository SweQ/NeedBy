//
//  GroupDetailsPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 13.09.22.
//

import Foundation
import UIKit

protocol GroupDetailsPresenterProtocol {
    func getComponentsCount() -> Int
    func getProductInBasket(with identifier: IndexPath) -> ProductInBasket
    func getTitle() -> String
    func removeProductFromGroup(with index: IndexPath)
    func addButtonPressed()
    func addProductInBasket(productInBasket: ProductInBasket, tableView: UITableView)
}

protocol GroupDetailsViewControllerProtocol: NSObject {
    
}

class GroupDetailsPresenter: GroupDetailsPresenterProtocol {
    
    weak var view: GroupDetailsViewControllerProtocol?
    
    var productGroup: ProductsGroup
    var productsInBasket: [ProductInBasket] {
        if let array = productGroup.productsInBasket?.allObjects as? [ProductInBasket] {
            return array
        }
        
        return []
    }
    
    init(productGroup: ProductsGroup) {
        self.productGroup = productGroup
    }
    
    func getTitle() -> String {
        return productGroup.name ?? "No group name"
    }
    
    func getComponentsCount() -> Int {
        return productGroup.productsInBasket?.count ?? 0
    }
    
    func getProductInBasket(with identifier: IndexPath) -> ProductInBasket
    {
        let productInBasket = productsInBasket[identifier.row]
        return productInBasket
    }
    
    func removeProductFromGroup(with index: IndexPath) {
        let productInBasket = productsInBasket[index.row]
        CoreDataManager.share.deleteObject(object: productInBasket)
        CoreDataManager.share.saveContext()
    }
    
    func addButtonPressed() {
        Coordinator.shared.goToProductsController()
    }
    
    func addProductInBasket(productInBasket: ProductInBasket, tableView: UITableView) {
        if let sameProductInBasket = productsInBasket.first(where: { p in
            p.product?.name == productInBasket.product?.name
        }) {
            sameProductInBasket.count += productInBasket.count
        } else {
            productGroup.addToProductsInBasket(productInBasket)
        }
        CoreDataManager.share.saveContext()
        tableView.reloadData()
    }
    
}
