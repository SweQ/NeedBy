//
//  Product+CoreDataProperties.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//
//

import Foundation
import CoreData
import UIKit


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var cost: Double
    @NSManaged public var image: UIImage?
    @NSManaged public var measure: String?
    @NSManaged public var name: String?
    @NSManaged public var currentBaskets: NSSet?
}


// MARK: Generated accessors for currentBaskets
extension Product {

    @objc(addCurrentBasketsObject:)
    @NSManaged public func addToCurrentBaskets(_ value: ProductInBasket)

    @objc(removeCurrentBasketsObject:)
    @NSManaged public func removeFromCurrentBaskets(_ value: ProductInBasket)

    @objc(addCurrentBaskets:)
    @NSManaged public func addToCurrentBaskets(_ values: NSSet)

    @objc(removeCurrentBaskets:)
    @NSManaged public func removeFromCurrentBaskets(_ values: NSSet)

}

extension Product : Identifiable {

}
