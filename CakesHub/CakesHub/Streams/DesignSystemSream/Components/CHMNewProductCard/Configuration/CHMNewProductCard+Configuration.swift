//
//  CHMNewProductCard+Configuration.swift
//  CHMUIKIT
//
//  Created by Dmitriy Permyakov on 20.01.2024.
//

import SwiftUI

extension CHMNewProductCard {

    struct Configuration {

        typealias OwnerViewType = CHMNewProductCard

        /// Configuration of the image view
        var imageConfiguration: MKRImageView.Configuration = .clear
        var badgeViewConfiguration: CHMBadgeView.Configuration = .clear
        var productButtonConfiguration: CHMProductButton.Configuration = .clear
        var starsViewConfiguration: CHMStarsView.Configuration = .clear
        var productText: ProductText = .clear
    }
}

extension CHMNewProductCard.Configuration {

    struct ProductText {
        var seller: String?
        var productName: String?
        var productPrice: String = .clear
        var productOldPrice: String?

        static let clear = Self()
    }
}
