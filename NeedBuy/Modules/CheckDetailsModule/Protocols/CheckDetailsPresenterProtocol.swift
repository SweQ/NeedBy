//
//  CheckDetailsPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import Foundation

protocol CheckDetailsPresenterProtocol {
    func getPurchaseProductsCount() -> Int
    func getCheckTitle() -> String
    func getPurchasedProduct(at index: IndexPath) -> PurchasedProduct
    func getTotalPrice() -> Double
}
