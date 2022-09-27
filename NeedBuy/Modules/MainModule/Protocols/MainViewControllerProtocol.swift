//
//  MainViewControllerProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import Foundation
import UIKit

protocol MainViewControllerProtocol: NSObject {
    func beginUpdateTable()
    func insertRowsInTable(at indexes: [IndexPath])
    func deleteRowsInTable(at indexes: [IndexPath])
    func updateRowInTable(at index: IndexPath, purchase: Purchase) 
    func endUpdateTable()
    func presentAlert(alert: UIAlertController)
}
