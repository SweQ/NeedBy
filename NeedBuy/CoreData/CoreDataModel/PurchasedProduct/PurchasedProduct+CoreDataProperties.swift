//
//  PurchasedProduct+CoreDataProperties.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//
//

import Foundation
import CoreData


extension PurchasedProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchasedProduct> {
        return NSFetchRequest<PurchasedProduct>(entityName: "PurchasedProduct")
    }

    @NSManaged public var unitCost: Double
    @NSManaged public var count: Double
    @NSManaged public var name: String?
    @NSManaged public var totalCost: Double
    @NSManaged public var measure: String?
    @NSManaged public var check: Check?

}

extension PurchasedProduct : Identifiable {

}
