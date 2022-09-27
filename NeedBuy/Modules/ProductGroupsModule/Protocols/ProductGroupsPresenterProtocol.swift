//
//  ProductGroupsPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 19.09.22.
//

import Foundation

protocol ProductGroupsPresenterProtocol {
    func showGroupDetails(at index: IndexPath)
    func getCountOfProducts() -> Int
    func getGroup(with index: IndexPath) -> ProductsGroup
    func removeGroup(with index: IndexPath)
    func selectGroup(at index: IndexPath)
}
