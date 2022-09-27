//
//  PurchaseManager.swift
//  NeedBuy
//
//  Created by alexKoro on 14.09.22.
//

import Foundation

class PurchaseManager {
    static let share = PurchaseManager()
    private let dataManager = CoreDataManager.share
    private init() { }
    
    func purchaseProduct(productInBasket: ProductInBasket) {
        let check = dataManager.createCheck(at: Date.now)
        
        let count = productInBasket.count
        let price = productInBasket.product?.cost ?? 0
        guard let product = productInBasket.product,
              let name = product.name,
              let measure = product.measure
        else { return }
        
        dataManager.savePurhasedProduct(
            with: name,
            count: count,
            unitCost: price,
            measure: measure,
            check: check
        )
    }
    
    func purchaseAllComponents(in purchase: Purchase) {
        let set = purchase.productsInBasket?.allObjects
        guard let productsInBasket = set as? [ProductInBasket]
        else { return }
        
        productsInBasket.forEach { productInBasket in
            purchaseProduct(productInBasket: productInBasket)
        }
    }
}
