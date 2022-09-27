//
//  ChecksPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import Foundation

protocol ChecksPresenterProtocol {
    func getChecksCount() -> Int
    func getChecksTitle(at index: IndexPath) -> String
    func openCheck(at index: IndexPath)
    func deleteCheck(at index: IndexPath)
}
