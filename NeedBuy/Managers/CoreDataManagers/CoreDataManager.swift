//
//  CoreDataManager.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let share = CoreDataManager()
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NeedBuy")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createCheck(at date: Date) -> Check {
        if let existingCheck = getCheck(at: date) {
            return existingCheck
        } else {
            let check = Check(context: viewContext)
            check.date = date.shortStringDate()
            return check
        }
    }
    
    func downloadChecks() -> [Check] {
        let fetchRequest = NSFetchRequest<Check>(entityName: "Check")
        guard let checks = try? viewContext.fetch(fetchRequest) else { return [] }
        return checks
    }
    
    func getCheck(at date: Date) -> Check? {
        let fetchRequest = NSFetchRequest<Check>(entityName: "Check")
        let predicate = NSPredicate(
            format: "date == %@",
            date.shortStringDate()
        )
        print(date.shortStringDate())
        fetchRequest.predicate = predicate
        guard let results = try? viewContext.fetch(fetchRequest),
              let check = results.first
        else { return nil}
        
        return check
    }
    
    func getCheck() -> Check? {
        let fetchRequest = NSFetchRequest<Check>(entityName: "Check")

        guard let results = try? viewContext.fetch(fetchRequest),
              let check = results.first
        else { return nil}
        
        return check
    }
    
    func savePurhasedProduct(with name: String,
                             count: Double,
                             unitCost: Double,
                             measure: String,
                             check: Check) {
        let _ = createPurchasedProduct(with: name, count: count, unitCost: unitCost, measure: measure, check: check)
        saveContext()
    }
    
    private func createPurchasedProduct(with name: String,
                                count: Double,
                                unitCost: Double,
                                measure: String,
                                check: Check
    ) -> PurchasedProduct {
        let purchasedProduct = PurchasedProduct(context: viewContext)
        purchasedProduct.name = name
        purchasedProduct.unitCost = unitCost
        purchasedProduct.totalCost = unitCost * Double(count)
        purchasedProduct.measure = measure
        purchasedProduct.check = check
        purchasedProduct.count = count
        
        return purchasedProduct
    }
    
    func createProduct(name: String, measure: Measure, cost: Double, image: UIImage? ) -> Product {
        let product = Product(context: viewContext)
        product.name = name
        product.measure = measure.rawValue
        product.cost = cost
        if let image = image {
            product.image = image
        }
        
        return product
    }
    
    func createProductInBasket(product: Product, count: Double) -> ProductInBasket {
        let productInBasket = ProductInBasket(context: viewContext)
        productInBasket.product = product
        productInBasket.count = count
        
        return productInBasket
    }
    
    func createProductGroup(name: String, productsInBasket: [ProductInBasket]) -> ProductsGroup {
        let productGroup = ProductsGroup(context: viewContext)
        productGroup.productsInBasket = NSSet(array: productsInBasket)
        productGroup.name = name
        
        return productGroup
    }
    
    func isHaveGroupName(with name: String) -> Bool {
        let predicate = NSPredicate(format: "name = %@", name)
        let fetchRequest: NSFetchRequest<ProductsGroup> = NSFetchRequest(entityName: "ProductsGroup")
        fetchRequest.predicate = predicate
        
        if let result = try? viewContext.fetch(fetchRequest) {
            return result.count > 0
        } else {
            return false
        }
    }
    
    func createPurchase(date: Date, title: String, productsInBasket: [ProductInBasket]) -> Purchase {
        let purchase = Purchase(context: viewContext)
        purchase.date = date
        purchase.productsInBasket = NSSet(array: productsInBasket)
        purchase.title = title
        
        return purchase
    }
    
    func downloadProducts() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = NSFetchRequest(entityName: "Product")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let result = try? viewContext.fetch(fetchRequest)
        else { return [] }
        
        return result
    }
    
    func dowloadProductGroups() -> [ProductsGroup] {
        let fetchRequest: NSFetchRequest<ProductsGroup> = NSFetchRequest(entityName: "ProductsGroup")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(ProductsGroup.name), ascending: true)]
        if let result = try? viewContext.fetch(fetchRequest) {
            return result
        }
        
        return []
    }
    
    func downloadProducts(with predicate: NSPredicate) -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = NSFetchRequest(entityName: "Product")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let result = try? viewContext.fetch(fetchRequest)
        else { return [] }
        
        return result
    }
    
    func downloadPurchases() -> [Purchase] {
        let fetchRequest: NSFetchRequest<Purchase> = NSFetchRequest(entityName: "Purchase")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        guard let result = try? viewContext.fetch(fetchRequest)
        else { return [] }
        
        return result
    }
    
    func downloadPurchases(with date: Date) -> [Purchase] {

        var result: [Purchase] = []

        let purchases = downloadPurchases()
        purchases.forEach { purchase in
            guard let purchaseDate = purchase.date else { return }
            if purchaseDate.shortStringDate() == date.shortStringDate() {
                result.append( purchase)
            }
        }
        
        return result
    }
    
    func isPurchaseTitleFree(title: String) -> Bool {
        let attribute = #keyPath(Purchase.title)
        
        let predicate = NSPredicate(format: "\(attribute) = %@", title)
        if downloadPurchases(with: predicate).count > 0 {
            return false
        } else {
            return true
        }
    }
    
    func isProductNameFree(name: String) -> Bool {
        let attribute = #keyPath(Product.name)
        let predicate = NSPredicate(format: "\(attribute) = %@", name)
        return !(downloadProducts(with: predicate).count > 0)
    }
    
    func downloadPurchases(with predicate: NSPredicate) -> [Purchase] {
        let fetchRequest: NSFetchRequest<Purchase> = NSFetchRequest(entityName: "Purchase")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        guard let result = try? viewContext.fetch(fetchRequest)
        else { return [] }
        
        return result
    }
    
    func getPurchaseFetchController(with title: String, fetchRequest: NSFetchRequest<ProductInBasket>) -> NSFetchedResultsController<ProductInBasket> {
        
        let predicate = NSPredicate(format: "currentPurchase.title = %@", title)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "product.name", ascending: true)]
        let controller = NSFetchedResultsController(
        fetchRequest: fetchRequest,
        managedObjectContext: viewContext,
        sectionNameKeyPath: nil,
        cacheName: nil)
        
        return controller
    }
    
    func getPurchases(with product: Product) -> [Purchase] {
        var resultPurchase: [Purchase] = []
        let request = Purchase.fetchRequest()
        
        guard let purchases = try? viewContext.fetch(request) else { return resultPurchase }
        purchases.forEach { purchase in
            let productsInBasket = purchase.productsInBasket?.allObjects as? [ProductInBasket] ?? []
            productsInBasket.forEach { productInBasket in
                if productInBasket.product?.name == product.name {
                    resultPurchase.append(purchase)
                }
            }
        }
        
        return resultPurchase
    }
    
    func getGroups(with product: Product) -> [ProductsGroup] {
        var result: [ProductsGroup] = []
        let request = ProductsGroup.fetchRequest()
        
        guard let groups = try? viewContext.fetch(request) else { return result }
        groups.forEach { group in
            let productsInBasket = group.productsInBasket?.allObjects as? [ProductInBasket] ?? []
            productsInBasket.forEach { productInBasket in
                if productInBasket.product?.name == product.name {
                    result.append(group)
                }
            }
        }
        return result
    }
    
    func getFetchController<T>(fetchRequest: NSFetchRequest<T>) -> NSFetchedResultsController<T> {
        
        if T.self != Purchase.self && T.self != Check.self {
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        } else {
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        }

        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        return controller
    }
    
    func deleteObject(object: NSManagedObject) {
        viewContext.delete(object)
    }
    
}
