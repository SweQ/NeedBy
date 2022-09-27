//
//  String + toDouble.swift
//  NeedBuy
//
//  Created by alexKoro on 15.09.22.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        let string = self.replacingOccurrences(of: ",", with: ".")
        return Double(string)
    }
}
