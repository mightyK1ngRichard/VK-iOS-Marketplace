//
//  ProductRequest+MockData.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//

import UIKit

#if DEBUG

extension ProductRequest {

    static let mockData = ProductRequest(
        images: .images([
            .cakeImageMock,
            .cakeImageMock,
            .cakeImageMock,
        ]),
        badgeText: "NEW",
        pickers: [],
        productName: "Клубничное облако",
        price: "1250 " + .rub,
        oldPrice: "1400 " + .rub,
        sellerName: RegisterUserRequest.mockData.nickname,
        description: .description,
        reviewInfo: .mockData,
        similarProducts: []
    )
}

private extension String {

    static let description = "Нежнейший клубничный мусс со сливками, покрыт шоколадным велюром."
}

#endif
