//
//  Date+shortStringDate.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import Foundation

extension Date {
    func shortStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: self)
    }
}
