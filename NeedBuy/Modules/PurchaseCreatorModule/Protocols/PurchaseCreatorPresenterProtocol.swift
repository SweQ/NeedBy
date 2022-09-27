//
//  PurchaseCreatorPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import Foundation

protocol PurchaseCreatorPresenterProtocol: NSObject {
    func createPurchase(with date: Date)
    func showPurchaseTitleAlert()
    func getCountOfProductsInBasket() -> Int
    func removeProductFromBasket(at index: IndexPath)
    func nextStep(with stepsCount: Int)
    func previosStep(with stepsCount: Int)
    func addProductInBasket(productInBasket: ProductInBasket)
    func addButtonPressed()
    func getProductInBasket(with index: IndexPath) -> ProductInBasket
}


