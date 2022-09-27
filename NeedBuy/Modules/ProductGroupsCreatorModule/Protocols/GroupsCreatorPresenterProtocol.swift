//
//  GroupsCreatorPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 16.09.22.
//

import UIKit

protocol GroupsCreatorPresenterProtocol {
    func addComponentButtonPressed()
    func saveButtonPressed()
    func addProductInBasket(productInBasket: ProductInBasket, tableView: UITableView)
    func showAlertForName(title: String, defaultValue: String)
    func getCountOfProductsInGroup() -> Int
    func getCellTitle(at index: IndexPath) -> String
    func cleareTemp()
}
