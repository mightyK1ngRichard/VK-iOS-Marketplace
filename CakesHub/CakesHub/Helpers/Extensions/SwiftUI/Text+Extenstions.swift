//
//  Text+Extenstions.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 23.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI

extension Text {

    func style(
        _ size: CGFloat,
        _ weight: Font.Weight,
        _ color: Color = CHMColor<TextPalette>.textPrimary.color
    ) -> some View {
        font(.system(size: size, weight: weight))
            .foregroundStyle(color)
    }
}
