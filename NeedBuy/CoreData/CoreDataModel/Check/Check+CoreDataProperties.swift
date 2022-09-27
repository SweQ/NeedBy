//
//  Check+CoreDataProperties.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//
//

import Foundation
import CoreData


extension Check {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Check> {
        return NSFetchRequest<Check>(entityName: "Check")
    }

    @NSManaged public var date: String?
    @NSManaged public var purchasedProducts: NSSet?

}

// MARK: Generated accessors for purchasedProducts
extension Check {

    @objc(addPurchasedProductsObject:)
    @NSManaged public func addToPurchasedProducts(_ value: PurchasedProduct)

    @objc(removePurchasedProductsObject:)
    @NSManaged public func removeFromPurchasedProducts(_ value: PurchasedProduct)

    @objc(addPurchasedProducts:)
    @NSManaged public func addToPurchasedProducts(_ values: NSSet)

    @objc(removePurchasedProducts:)
    @NSManaged public func removeFromPurchasedProducts(_ values: NSSet)

}

extension Check : Identifiable {

}
