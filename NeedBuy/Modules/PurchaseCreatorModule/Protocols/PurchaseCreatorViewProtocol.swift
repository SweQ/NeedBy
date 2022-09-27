//
//  PurchaseCreatorViewProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import UIKit

protocol PurchaseCreatorViewProtocol: NSObject {
    var productsTable: UITableView? {get}
    func showVC(viewController: UIViewController)
    func showStepView(with index: Int)
    func hideStepView(with index: Int)
    func showAlert(alert: UIAlertController)
}
