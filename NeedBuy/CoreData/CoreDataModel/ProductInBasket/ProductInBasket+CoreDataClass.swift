//
//  ProductInBasket+CoreDataClass.swift
//  NeedBuy
//
//  Created by alexKoro on 25.07.22.
//
//

import Foundation
import CoreData

@objc(ProductInBasket)
public class ProductInBasket: NSManagedObject {
    func getCost() -> Double {
        let productPrice = product?.cost ?? 0
        
        return productPrice * Double(count)
    }
}
