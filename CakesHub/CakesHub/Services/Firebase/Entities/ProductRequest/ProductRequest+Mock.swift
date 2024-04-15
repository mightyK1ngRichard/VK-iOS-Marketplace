//
//  ProductRequest+Mock.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import UIKit

#if DEBUG
extension ProductRequest: Mockable {

    static let mockData = ProductRequest(
        images: .images([
            CHMImage.mockImageCake,
            CHMImage.mockImageCake2,
            CHMImage.mockImageCake3,
        ]),
        pickers: [],
        productName: "Клубничное облако",
        price: "1400" + .space + .rub,
        discountedPrice: "1250" + .space + .rub,
        seller: .mockData,
        description: "Нежнейший клубничный мусс со сливками, покрыт шоколадным велюром.",
        similarProducts: [], 
        reviewInfo: .clear
    )
}
#endif
