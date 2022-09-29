//
//  Double+shortString.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import Foundation

extension Double {
    func shortString() -> String {
        return String(format: "%.2f", self)
    }
}
