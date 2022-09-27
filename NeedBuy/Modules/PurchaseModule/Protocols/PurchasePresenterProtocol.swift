//
//  PurchasePresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 6.09.22.
//

import Foundation
import UIKit

protocol PurchasePresenterProtocol: NSObject {
    func createTitleString() -> String
    func getCountOfProducts() -> Int
    func getProductInBasket(at index: IndexPath) -> ProductInBasket?
    func selectProductInBasket(at index: IndexPath)
    func setupCell(cell: ProductInBasketViewCell, index: IndexPath)
    func removeProductFromBasket(at index: IndexPath)
    func addProductInBasket(newProductInBasket: ProductInBasket)
    func addProductButtonPressed()
    func purchaseProductButtonPressed(at index: IndexPath)
    func setupTotalPrice()
}
