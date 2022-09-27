//
//  PurchaseViewControllerProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 6.09.22.
//

import Foundation
import UIKit

protocol PurchaseViewControllerProtocol: NSObject {
    var purchasesTable: UITableView? {get}
    
    func showAlertController(alert: UIAlertController)
    func updateTotalCost(with totalCost: String)
}
