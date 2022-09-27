//
//  Coordinator.swift
//  NeedBuy
//
//  Created by alexKoro on 6.09.22.
//

import Foundation
import UIKit

class Coordinator {
    
    static let shared = Coordinator()
    private var navigationController: UINavigationController? {
        didSet {
            navigationController?.navigationBar.tintColor = .black
        }
    }
    private let controllersCreator = ControllersCreator.standart
    private init() {
    }
    
    func start(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.popToRootViewController(animated: true)
        pushMainViewController()
    }
    
    private func pushMainViewController() {
        let mainVC = controllersCreator.createMainVC()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func goToPurchaseCreatorController() {
        let purchaseCreatorVC = controllersCreator .createPurchaseCreatorVC()
        navigationController?.pushViewController(purchaseCreatorVC, animated: true)
    }
    
    func goToPurchaseController(with purchase: Purchase) {
        let purchaseVC = controllersCreator.createPurchaseVC(with: purchase)
        navigationController?.pushViewController(purchaseVC, animated: true)
    }
    
    func goToProductGroupsController() {
        let productGroupsVC = controllersCreator.createProductGroupsVC()
        navigationController?.pushViewController(productGroupsVC, animated: true)
    }
    
    func goToProductGroupsCreatorController() {
        let groupsCreatorVC = controllersCreator.createProductGroupsCreatorVC()
        navigationController?.pushViewController(groupsCreatorVC, animated: true)
    }
    
    func goToProductGroupDetailsController(with group: ProductsGroup) {
        let groupsDetailsVC = controllersCreator.createGroupDetailsVC(with: group)
        navigationController?.pushViewController(groupsDetailsVC, animated: true)
    }
    
    func goToChecksController() {
        let checksVC = controllersCreator.createChecksVC()
        navigationController?.pushViewController(checksVC, animated: true)
    }
    
    func goToCheckDetails(for check: Check) {
        let checkDetailsVC = controllersCreator.createCheckDetailsVC(for: check)
        
        navigationController?.pushViewController(checkDetailsVC, animated: true)
    }
    
    func goToProductsController() {
        let productsVC = controllersCreator.createProductsVC()
        navigationController?.pushViewController(productsVC, animated: true)
    }
    
    func goToSelectProductsController(with handler: @escaping (ProductInBasket)->()) {
        let productsVC = controllersCreator.createProductsVC()
        productsVC.presenter?.selectProductToBasketHandler = handler
        navigationController?.pushViewController(productsVC, animated: true)
    }
    
    func goToProductCreatorController(with product: Product?) {
        let productCreatorVC = controllersCreator.createProductCreatorVC(with: product)
        navigationController?.pushViewController(productCreatorVC, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func previosViewController() -> UIViewController? {
        let viewControllers = navigationController?.viewControllers ?? []
        
        if viewControllers.count < 2 {
            return nil
        }
        
        return viewControllers[viewControllers.count - 2]
    }
}
