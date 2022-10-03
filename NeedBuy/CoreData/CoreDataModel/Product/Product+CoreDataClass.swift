//
//  Product+CoreDataClass.swift
//  NeedBuy
//
//  Created by alexKoro on 29.07.22.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {

    func getMeasureString() -> String {
        guard let measure = Measure(rawValue: measure ?? Measure.pcs.rawValue) else { return Measure.pcs.stringValue() }
        
        return measure.stringValue()
    }
}
