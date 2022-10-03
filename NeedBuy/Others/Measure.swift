//
//  Measure.swift
//  NeedBuy
//
//  Created by alexKoro on 25.07.22.
//

import Foundation

enum Measure: String, CaseIterable {
    case kg
    case pcs
    case liter
    
    func stringValue() -> String {
        return self.rawValue.localize()
    }
}
