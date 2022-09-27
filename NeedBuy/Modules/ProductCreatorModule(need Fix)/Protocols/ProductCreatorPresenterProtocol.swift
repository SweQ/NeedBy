//
//  ProductCreatorPresenterProtocol.swift
//  NeedBuy
//
//  Created by alexKoro on 22.08.22.
//

import UIKit

protocol ProductCreatorPresenterProtocol: NSObject, UITextFieldDelegate {
    func save(productName: String,
                                productMeasure: Measure,
                                productCost: Double,
                                productImage: UIImage?)
    func updateProductImage(image: UIImage, with handler: (() -> ())?)
    func prepareViewToAppear()
    var editingProduct: Product? {get set}
}
