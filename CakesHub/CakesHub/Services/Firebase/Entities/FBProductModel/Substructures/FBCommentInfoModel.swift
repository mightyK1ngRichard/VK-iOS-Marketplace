//
//  CommentInfoRequest.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 15.04.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import Foundation

extension FBProductModel {
    
    struct FBCommentInfoModel: FBModelable {
        var id             : String
        var userName       : String
        var date           : String
        var description    : String
        var countFillStars : Int
        var feedbackCount  : Int
        
        static let clear = FBCommentInfoModel(
            id: .clear,
            userName: .clear,
            date: .clear,
            description: .clear,
            countFillStars: 0,
            feedbackCount: 0
        )
    }
}

// MARK: - DictionaryConvertible

extension FBProductModel.FBCommentInfoModel {

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String else { return nil }
        self.init(
            id: id,
            userName: dictionary["userName"] as? String ?? .clear,
            date: dictionary["date"] as? String ?? .clear,
            description: dictionary["description"] as? String ?? .clear,
            countFillStars: dictionary["countFillStars"] as? Int ?? 0,
            feedbackCount: dictionary["feedbackCount"] as? Int ?? 0
        )
    }
}

// MARK: - Mapper

extension FBProductModel.FBCommentInfoModel {

    var mapper: ProductReviewsModel.CommentInfo {
        .init(
            id: id,
            userName: userName,
            date: date,
            description: description,
            countFillStars: countFillStars,
            feedbackCount: feedbackCount
        )
    }
}

extension [FBProductModel.FBCommentInfoModel] {

    var mapper: [ProductReviewsModel.CommentInfo] {
        map { $0.mapper }
    }
}

// MARK: - <#text#>

extension FBProductModel.FBCommentInfoModel: Equatable {

    static func == (
        lhs: FBProductModel.FBCommentInfoModel,
        rhs: FBProductModel.FBCommentInfoModel
    ) -> Bool {
        lhs.id             == rhs.id &&
        lhs.userName       == rhs.userName &&
        lhs.date           == rhs.date &&
        lhs.description    == rhs.description &&
        lhs.countFillStars == rhs.countFillStars &&
        lhs.feedbackCount  == rhs.feedbackCount
    }
}
