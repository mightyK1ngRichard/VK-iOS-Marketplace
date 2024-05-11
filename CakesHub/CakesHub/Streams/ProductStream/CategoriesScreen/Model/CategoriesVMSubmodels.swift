//
//  CategoriesVMSubmodels.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 07.05.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import Foundation

// MARK: - Section

extension CategoriesViewModel {

    enum Section {
        case men([CategoryCardModel])
        case women([CategoryCardModel])
        case kids([CategoryCardModel])
    }

    enum FBSection {
        case men([FBCateoryModel])
        case women([FBCateoryModel])
        case kids([FBCateoryModel])

        var items: [FBCateoryModel] {
            switch self {
            case let .men(items):
                return items
            case let .women(items):
                return items
            case let .kids(items):
                return items
            }
        }
    }
}

extension CategoriesViewModel.Section: Identifiable{

    var id: Int {
        switch self {
        case .men: return 1
        case .women: return 2
        case .kids: return 3
        }
    }

    var items: [CategoryCardModel] {
        switch self {
        case let .men(items):
            return items
        case let .women(items):
            return items
        case let .kids(items):
            return items
        }
    }
}

// MARK: - Screens

extension CategoriesViewModel {

    enum Screens {
        case sectionCakes([FBProductModel])
    }
}

extension CategoriesViewModel.Screens: Identifiable, Hashable {

    var id: Int {
        switch self {
        case .sectionCakes: return 1
        }
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
