//
//  CGSize+Ext.swift
//  CakeHubApplication
//
//  Created by Дмитрий Пермяков on 04.10.2023.
//  Copyright 2023 © VK Team CakesHub. All rights reserved.
//

import UIKit

extension CGSize: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}
