//
//  GroupsCreatorViewControllerProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 16.09.22.
//

import UIKit

protocol GroupsCreatorViewControllerProtocol: NSObject {
    func presentAlert(alert: UIAlertController)
    func changeTitle(title: String)
}
