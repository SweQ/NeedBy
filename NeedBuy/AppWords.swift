//
//  AppWords.swift
//  NeedBuy
//
//  Created by alexKoro on 29.09.22.
//

import Foundation

enum Words: String {
    case mainViewTitle
    case doneTitle
    case deleteTitle
    case planingDateTitle
    case productsTitle
    case checksTitle
    case productGroupsTitle
    case menuTitle
    case enterGroupNameTitle
    case newGroupTitle
    case productGroupCreatorTitle
    case addComponentTitle
    case saveTitle
    case countTitle
    case costTitle
    case okTitle
    case groupWithName
    case alreadyCreated
    case creatingTitle
    case buyTitle
    case priceTitle
    case totalPriceTitle
    case editTitle
    case selectActionFor
    case enterCount
    case sourceTitle
    case per1
    case unableToDelete
    case purchasesTitle
    case groupsTitle
    case thisProductContainsIn
    case countOfProduct
    case enterCountOfProduct
    case addTitle
    case errorTitle
    case costIsNotCorrect
    case exampleTitle
    case selectMeasure
    case changeImage
    case nameTitle
    case defaultWord
    case measureTitle
    case pcs
    case productMustHaveName
    case thisNameIsAlreadyUse
    case createNewProduct
    case creatingNewPurchase
    case errorEmptyBasket
    case addProduct
    case backTitle
    case nextTitle
    case createTitle
    case purchaseName
    case enterPurchaseName
    case purchaseMustHasName
    case titleIsExists
    case cancelTitle
    case todayYouHavePurchases
    
    func value() -> String {
        return self.rawValue.localize()
    }
}
