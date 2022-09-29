//
//  String + localize.swift
//  NeedBuy
//
//  Created by alexKoro on 29.09.22.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: .main, value: self, comment: "")
    }
}
