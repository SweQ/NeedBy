//
//  ProductsViewProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import UIKit

protocol ProductsViewProtocol: NSObject {
    var productsTable: UITableView? { get }
  
    func showAlertController(alert: UIAlertController)
}
