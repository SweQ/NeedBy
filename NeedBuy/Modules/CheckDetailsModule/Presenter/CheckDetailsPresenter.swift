//
//  CheckDetailsPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import Foundation

class CheckDetailsPresenter {
    
    var check: Check?
    weak var view: CheckDetailsControllerProtocol?
    
    private var purchasedProducts: [PurchasedProduct] {
        guard let array = check?.purchasedProducts?.allObjects as? [PurchasedProduct] else {
            return []
        }
        return array
    }
    
    init(check: Check) {
        self.check = check
    }
    
}

//MARK: -CheckDetailsPresenterProtocol
extension CheckDetailsPresenter: CheckDetailsPresenterProtocol {
    func getPurchasedProduct(at index: IndexPath) -> PurchasedProduct {
        return purchasedProducts[index.row]
    }
    
    func getCheckTitle() -> String {
        let checkDate = check?.date ?? "-"
        return "Check from \(checkDate)"
    }
    
    func getPurchaseProductsCount() -> Int {
        return purchasedProducts.count
    }
    
    func getTotalPrice() -> Double {
        var totalPrice = 0.0
        
        guard let checkObjects = check?.purchasedProducts?.allObjects as? [PurchasedProduct] else { return totalPrice }
        
        checkObjects.forEach { purchasedProduct in
            totalPrice += purchasedProduct.totalCost
        }
        
        return totalPrice
    }
}
