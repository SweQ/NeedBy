//
//  Purchase+CoreDataProperties.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var productsInBasket: NSSet?

}

// MARK: Generated accessors for productsInBasket
extension Purchase {

    @objc(addProductsInBasketObject:)
    @NSManaged public func addToProductsInBasket(_ value: ProductInBasket)

    @objc(removeProductsInBasketObject:)
    @NSManaged public func removeFromProductsInBasket(_ value: ProductInBasket)

    @objc(addProductsInBasket:)
    @NSManaged public func addToProductsInBasket(_ values: NSSet)

    @objc(removeProductsInBasket:)
    @NSManaged public func removeFromProductsInBasket(_ values: NSSet)

}

extension Purchase : Identifiable {

}
