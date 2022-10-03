//
//  PurchasedProduct+CoreDataClass.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//
//

import Foundation
import CoreData

@objc(PurchasedProduct)
public class PurchasedProduct: NSManagedObject {
    func getMeasureString() -> String {
        guard let measure = Measure(rawValue: measure ?? Measure.pcs.rawValue) else { return Measure.pcs.stringValue() }
        
        return measure.stringValue()
    }
}

