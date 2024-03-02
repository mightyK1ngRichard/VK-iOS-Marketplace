//
//  ProductModel.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 04.02.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI
import UIKit

struct ProductModel: Identifiable, Hashable {
    let id              = UUID()
    var productID       : Int
    var images          : [ProductImage] = []
    var badgeText       : String = .clear
    var isFavorite      : Bool = false
    var pickers         : [String] = []
    var productName     : String = .clear
    var price           : String = .clear
    var oldPrice        : String?
    var sellerName      : String = .clear
    var description     : String = .clear
    var reviewInfo      : ProductReviewsModel = .clear
    var similarProducts : [SimilarCard] = []
}

extension ProductModel {

    struct ProductImage: Identifiable {
        let id = UUID()
        var kind: MKRImageView.Configuration.ImageKind
    }

    struct SimilarCard: Identifiable {
        let id = UUID()
        var configuration: CHMNewProductCard.Configuration = .clear
    }

    var starsCount: Int {
        Int(reviewInfo.averageRating.rounded())
    }
}

// MARK: - Hasher

extension ProductModel {

    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
