//
//  ProductGroupsCreatorPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//

import Foundation
import UIKit

class ProductGroupsCreatorPresenter: GroupsCreatorPresenterProtocol  {

    weak var view: GroupsCreatorViewControllerProtocol?
    var productGroup: ProductsGroup?
    private var isSaved = false
    
    private var productsInBasket: [ProductInBasket] {
        guard let productsInBasket = productGroup?.productsInBasket?.allObjects as? [ProductInBasket] else {
            return []
        }

        return productsInBasket
    }
    
    func addComponentButtonPressed() {
        Coordinator.shared.goToProductsController()
    }
    
    func getCellTitle(at index: IndexPath) -> String {
        guard let productsInBasket = productGroup?.productsInBasket?.allObjects as? [ProductInBasket] else {
            return "-"
        }
        
        let product = productsInBasket[index.row]
        guard let name = product.product?.name,
              let measure = product.product?.measure else { return "-"}
        return "\(name) \(Words.countTitle.value()): \(product.count) \(measure) \(Words.costTitle.value()): \(product.getCost().shortString())"

    }
    
    func saveButtonPressed() {
        CoreDataManager.share.saveContext()
        Coordinator.shared.popViewController()
        isSaved = true
    }
    
    func getCountOfProductsInGroup() -> Int {
        return productGroup?.productsInBasket?.count ?? 0
    }
    
    func showAlertForName(title: String, defaultValue: String) {
        let alert = createAlertForName(with: title, defaultValue: defaultValue)
        view?.presentAlert(alert: alert)
    }
    
    private func isUniqueGroupName(groupName: String) -> Bool {
        if CoreDataManager.share.isHaveGroupName(with: groupName) {
            return false
        } else {
            return true
        }
    }
    
    private func createAlertForName(with title: String, defaultValue: String) -> UIAlertController {
        let alert = AlertCreator.shared.createAlertWithCancel(title: title, message: nil, style: .alert, actions: []) {[weak self] in
            if self?.productGroup?.name == nil {
                Coordinator.shared.popViewController()
            }
        }
        alert.addTextField { nameTF in
            nameTF.text = defaultValue
        }
        let okAction = UIAlertAction(title: Words.okTitle.value(), style: .default) { [weak self] _ in
            guard let groupName = alert.textFields?.first?.text else { return }
            guard self?.isUniqueGroupName(groupName: groupName) ?? false else {
                
                self?.showAlertForName(title: "\(Words.groupWithName.value()) \'\(groupName)\' \(Words.alreadyCreated.value()).", defaultValue: groupName)
                return
            }
            if self?.productGroup == nil {
                self?.productGroup = CoreDataManager.share.createProductGroup(name: groupName, productsInBasket: [])
            } else {
                self?.productGroup?.name = groupName
            }
            
            self?.view?.changeTitle(title: "\(Words.creatingTitle.value()) \(groupName)")
        }
        alert.addAction(okAction)
        
        return alert
    }
    
    func cleareTemp() {
        if let productGroup = productGroup,
           !isSaved
        {
            CoreDataManager.share.deleteObject(object: productGroup)
        }
    }
    
    func addProductInBasket(productInBasket: ProductInBasket, tableView: UITableView) {
        
        if let sameProductInBasket = productsInBasket.first(where: { p in
            p.product?.name == productInBasket.product?.name
        }) {
            sameProductInBasket.count += productInBasket.count
        } else {
            productGroup?.addToProductsInBasket(productInBasket)
        }
        
        tableView.reloadData()
    }
}
