//
//  ProductInBasket+CoreDataProperties.swift
//  NeedBuy
//
//  Created by alexKoro on 15.09.22.
//
//

import Foundation
import CoreData


extension ProductInBasket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductInBasket> {
        return NSFetchRequest<ProductInBasket>(entityName: "ProductInBasket")
    }

    @NSManaged public var count: Double
    @NSManaged public var currentGroups: NSSet?
    @NSManaged public var currentPurchase: Purchase?
    @NSManaged public var product: Product?

}

// MARK: Generated accessors for currentGroups
extension ProductInBasket {

    @objc(addCurrentGroupsObject:)
    @NSManaged public func addToCurrentGroups(_ value: ProductsGroup)

    @objc(removeCurrentGroupsObject:)
    @NSManaged public func removeFromCurrentGroups(_ value: ProductsGroup)

    @objc(addCurrentGroups:)
    @NSManaged public func addToCurrentGroups(_ values: NSSet)

    @objc(removeCurrentGroups:)
    @NSManaged public func removeFromCurrentGroups(_ values: NSSet)

}

extension ProductInBasket : Identifiable {

}
