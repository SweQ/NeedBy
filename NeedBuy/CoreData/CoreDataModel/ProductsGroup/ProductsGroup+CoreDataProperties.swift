//
//  ProductsGroup+CoreDataProperties.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//
//

import Foundation
import CoreData


extension ProductsGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsGroup> {
        return NSFetchRequest<ProductsGroup>(entityName: "ProductsGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var productsInBasket: NSSet?

}

// MARK: Generated accessors for productsInBasket
extension ProductsGroup {

    @objc(addProductsInBasketObject:)
    @NSManaged public func addToProductsInBasket(_ value: ProductInBasket)

    @objc(removeProductsInBasketObject:)
    @NSManaged public func removeFromProductsInBasket(_ value: ProductInBasket)

    @objc(addProductsInBasket:)
    @NSManaged public func addToProductsInBasket(_ values: NSSet)

    @objc(removeProductsInBasket:)
    @NSManaged public func removeFromProductsInBasket(_ values: NSSet)

}

extension ProductsGroup : Identifiable {

}
