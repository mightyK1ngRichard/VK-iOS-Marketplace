//
//  ProductRequest.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI
import Firebase

struct ProductRequest: DictionaryConvertible, ClearConfigurationProtocol {
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
    var seller: UserRequest = .clear
    /// Описание товара
    var description: String = .clear
    /// Схожие товары
    var similarProducts: [String] = []
    /// Оценки товара
    var reviewInfo: ProductReviewsRequest = .clear

    static let clear = ProductRequest()
}

// MARK: - ProductRequest Substructures

extension ProductRequest {

    struct ProductReviewsRequest: ClearConfigurationProtocol, DictionaryConvertible {
        var countFiveStars  : Int = 0
        var countFourStars  : Int = 0
        var countThreeStars : Int = 0
        var countTwoStars   : Int = 0
        var countOneStars   : Int = 0
        var countOfComments : Int = 0
        var comments        : [CommentInfoRequest] = []

        static let clear = ProductReviewsRequest()
    }

    struct CommentInfoRequest: ClearConfigurationProtocol, DictionaryConvertible {
        var userName       : String = .clear
        var date           : String = .clear
        var description    : String = .clear
        var countFillStars : Int = 0
        var feedbackCount  : Int = 0

        static let clear = CommentInfoRequest()
    }

    enum ImageKindRequest: DictionaryConvertible {
        case url([URL?])
        case images([UIImage?])
        case strings([String])
        case clear
    }
}
