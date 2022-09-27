//
//  ControllersCreator.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import Foundation

class ControllersCreator{
    
    static let standart = ControllersCreator()
    private init() { }
    
    func createPurchaseCreatorVC() -> PurchaseCreatorViewController {
        let presenter = PurchaseCreatorPresenter()
        let viewController = PurchaseCreatorViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func createChecksVC() -> ChecksViewController {
        let preseneter = ChecksPresenter()
        let viewController = ChecksViewController()
        preseneter.view = viewController
        viewController.presenter = preseneter
        
        return viewController
    }
    
    func createCheckDetailsVC(for check: Check) -> CheckDetailsViewController {
        let checkDetailsVC = CheckDetailsViewController()
        let presenter = CheckDetailsPresenter(check: check)
        checkDetailsVC.presenter = presenter
        presenter.view = checkDetailsVC
        
        return checkDetailsVC
    }
    
    func createMainVC() -> MainViewController {
        let presenter = MainViewPresenter()
        let viewController = MainViewController()
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    func createPurchaseVC(with purchase: Purchase) -> PurchaseViewController {
        let presenter = PurchasePresenter(purchase: purchase)
        let viewController = PurchaseViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func createProductCreatorVC(with product: Product?) -> ProductCreatorViewController {
        let viewController = ProductCreatorViewController()
        let presenter = ProductCreatorPresenter(product: product)
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func createProductGroupsVC() -> ProductGroupsViewController {
        let presenter = ProductGroupsPresenter()
        let viewContoller = ProductGroupsViewController()
        viewContoller.presenter = presenter
        presenter.view = viewContoller
        
        return viewContoller
    }
    
    func createProductGroupsCreatorVC() -> ProductGroupsCreatorViewController {
        let presenter = ProductGroupsCreatorPresenter()
        let viewController = ProductGroupsCreatorViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func createProductsVC() -> ProductsViewController {
        let viewController = ProductsViewController()
        let presenter = ProductsViewPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func createGroupDetailsVC(with group: ProductsGroup) -> GroupDetailsViewController {
        let viewController = GroupDetailsViewController()
        let presenter = GroupDetailsPresenter(productGroup: group)
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
}
