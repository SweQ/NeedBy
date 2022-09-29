//
//  AlertCreator.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import Foundation
import UIKit

protocol AlertCreatorProtocol {
    func createAlertWithCancel(title: String?,
                     message: String?,
                     style: UIAlertController.Style,
                     actions: [UIAlertAction]
    ) -> UIAlertController
}

class AlertCreator: AlertCreatorProtocol {
    static let shared = AlertCreator()
    private init() { }
    
    func createAlertWithCancel(title: String?,
                     message: String?,
                     style: UIAlertController.Style,
                     actions: [UIAlertAction]
    ) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: style)
        
        actions.forEach {
            alertVC.addAction($0)
        }
        
        let cancelAction = UIAlertAction(
            title: Words.cancelTitle.value(),
            style: .cancel, handler: nil)
        cancelAction.setupTitleColor(.darkGray)
        alertVC.addAction(cancelAction)
        
        return alertVC
    }
    
    func createAlertWithCancel(title: String?,
                     message: String?,
                     style: UIAlertController.Style,
                     actions: [UIAlertAction],
                               cancelHandler: @escaping ()->()
    ) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: style)
        
        actions.forEach {
            alertVC.addAction($0)
        }
        
        let cancelAction = UIAlertAction(
            title: Words.cancelTitle.value(),
            style: .cancel) { _ in
            cancelHandler()
        }
        cancelAction.setupTitleColor(.darkGray)
        alertVC.addAction(cancelAction)

        return alertVC
    }
    
    func createErrorAlert(with title: String, message: String? ) -> UIAlertController {
        let errorAlert = createAlertWithCancel(title: title, message: message, style: .alert, actions: [])
        return errorAlert
    }
    
    func createErrorAlert(with title: String, message: String?, handler: @escaping ()->() ) -> UIAlertController {
        let errorAlert = createAlertWithCancel(title: title, message: message, style: .alert, actions: [], cancelHandler: handler)
        return errorAlert
    }
    
}
