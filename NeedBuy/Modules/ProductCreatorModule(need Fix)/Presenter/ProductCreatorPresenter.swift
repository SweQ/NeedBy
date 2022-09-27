//
//  ProductCreatorPresenter.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import UIKit

class ProductCreatorPresenter: NSObject, ProductCreatorPresenterProtocol {
    let coreDateManager = CoreDataManager.share
    var editingProduct: Product?
    weak var view: ProductCreatorViewProtocol?
    
    init(product: Product?) {
        super.init()
        self.editingProduct = product
    }
    
    func updateProductImage(image: UIImage, with handler: (() -> ())?) {
        editingProduct?.image = image
        coreDateManager.saveContext()
        DispatchQueue.main.async {
            handler?()
        }
    }
    
    func save(productName: String,
              productMeasure: Measure,
              productCost: Double,
              productImage: UIImage?) {
        
        guard !productName.isEmpty else {
            let errorAlert = AlertCreator.shared.createErrorAlert(
                with: "Error",
                message: "Product must have a name.")
            view?.showAlert(alert: errorAlert)
            return
        }
        
        guard coreDateManager.isProductNameFree(name: productName) || productName == editingProduct?.name ?? ""  else {
            let errorAlert = AlertCreator.shared.createErrorAlert(with: "Error!", message: "This name is already in use.")
            view?.showAlert(alert: errorAlert)
            return
        }
            
        if editingProduct != nil {
            changeProduct(productName: productName, productMeasure: productMeasure, productCost: productCost, productImage: productImage)
        } else {
            createNewProduct(
                with: productName,
                productMeasure: productMeasure,
                productCost: productCost,
                productImage: productImage
            )
        }
        
        coreDateManager.saveContext()
    }
    
    func prepareViewToAppear() {
        setupTitleView()
        showEditingProduct()
    }
    
    private func createNewProduct(with productName: String,
                                  productMeasure: Measure,
                                  productCost: Double,
                                  productImage: UIImage?) {
        let product = coreDateManager.createProduct(
            name: productName,
            measure: productMeasure,
            cost: productCost,
            image: productImage
        )
        editingProduct = product
    }
    
    private func changeProduct(productName: String,
                               productMeasure: Measure,
                               productCost: Double,
                               productImage: UIImage? ) {
        editingProduct?.name = productName
        editingProduct?.measure = productMeasure.rawValue
        editingProduct?.cost = productCost
        editingProduct?.image = productImage
    }
    
    private func showEditingProduct() {
        guard let product = editingProduct else {
            view?.turnOnEditingMode()
            return }
        view?.switchOffEditingMode()
        view?.showEditingProduct(product: product)
    }
    
    private func setupTitleView() {
        let title = editingProduct == nil ? "Create new product" : editingProduct?.name ?? "-"
        view?.setupTitle(title: title)
    }
}
