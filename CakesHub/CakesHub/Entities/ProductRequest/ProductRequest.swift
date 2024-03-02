//
//  ProductRequest.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI
import Firebase

struct ProductRequest {
    /// Картинки товара
    var images: ImageKindRequest = .clear
    /// Бейдж с информацией
    var badgeText: String = .clear
    /// Фильтры торта
    var pickers: [String] = []
    /// Название торта
    var productName: String = .clear
    /// Цена торта
    var price: String = .clear
    /// Старая цена торта
    var oldPrice: String?
    /// Вес торта
    var weight: String?
    /// Имя продовца
    var sellerName: String = .clear
    /// Описание товара
    var description: String = .clear
    /// Оценки товара
    var reviewInfo: ProductReviewsModel = .clear
    /// Схожие товары
    var similarProducts: [String] = []
}

// MARK: - ProductRequest

extension ProductRequest {

    enum ImageKindRequest {
        case url([URL?])
        case images([UIImage?])
        case clear
    }
}

// MARK: - Firebase

extension ProductRequest {

    func mapperToDictionaty(userID: String, images: [String]) -> [String: Any] {
        var cakeDict: [String: Any] = [:]
        cakeDict["images"] = images
        cakeDict["badgeText"] = badgeText
        cakeDict["pickers"] = []
        cakeDict["productName"] = productName
        cakeDict["price"] = price
        cakeDict["oldPrice"] = oldPrice
        cakeDict["weight"] = weight
        cakeDict["description"] = description
//        cakeDict["reviewInfo"] = reviewInfo
        cakeDict["similarProducts"] = similarProducts
        cakeDict["sellerName"] = Firestore.firestore()
            .collection(FirestoreCollections.users.rawValue)
            .document(userID)
        return cakeDict
    }
}
