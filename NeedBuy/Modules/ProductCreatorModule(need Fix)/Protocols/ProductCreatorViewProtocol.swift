//
//  ProductCreatorViewProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 22.08.22.
//

import UIKit

protocol ProductCreatorViewProtocol: NSObject {
    func setupTitle(title: String)
    func showEditingProduct(product: Product)
    func showAlert(alert: UIAlertController)
    func turnOnEditingMode()
    func switchOffEditingMode()
}
