//
//  Purchase+CoreDataClass.swift
//  NeedBuy
//
//  Created by alexKoro on 25.07.22.
//
//

import Foundation
import CoreData

@objc(Purchase)
public class Purchase: NSManagedObject {

    func getStringDate() -> String {
        guard let date = date else { return "date is nil"}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: date)
    }
    
    func getCost() -> Double {
        guard let productsInBasket = productsInBasket?.allObjects as? [ProductInBasket] else { return 0 }
        var cost: Double = 0
        
        for product in productsInBasket {
            cost += Double(Double(product.count) * (product.product?.cost ?? 0.0))
        }
        
        return cost
    }
    
    func getStringCost() -> String {
        let doubleCost = getCost()
        return doubleCost.shortString()
    }
    
    func getTitle() -> String {
        return title ?? "no name"
    }
    
    func getProductCount() -> Int {
        return productsInBasket?.count ?? 0
    }
}
