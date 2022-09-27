//
//  String + isDouble.swift
//  NeedBuy
//
//  Created by alexKoro on 11.09.22.
//

import Foundation

extension String {
    func isDouble() -> Bool {
        Double(self) != nil
    }
}
