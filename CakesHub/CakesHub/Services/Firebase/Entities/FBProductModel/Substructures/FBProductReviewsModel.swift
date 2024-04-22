//
//  ProductReviewsRequest.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 15.04.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import Foundation

extension FBProductModel {
    
    struct FBProductReviewsModel: FBModelable {
        var countFiveStars  : Int
        var countFourStars  : Int
        var countThreeStars : Int
        var countTwoStars   : Int
        var countOneStars   : Int
        var countOfComments : Int
        var comments        : [FBCommentInfoModel]
        
        static let clear = FBProductReviewsModel(
            countFiveStars: 0,
            countFourStars: 0,
            countThreeStars: 0,
            countTwoStars: 0,
            countOneStars: 0,
            countOfComments: 0,
            comments: []
        )
    }
}

// MARK: - DictionaryConvertible

extension FBProductModel.FBProductReviewsModel {

    init(dictionary: [String: Any]) {
        let comments = dictionary["comments"] as? [[String: Any]] ?? []
        self.init(
            countFiveStars: dictionary["countFiveStars"] as? Int ?? 0,
            countFourStars: dictionary["countFourStars"] as? Int ?? 0,
            countThreeStars: dictionary["countThreeStars"] as? Int ?? 0,
            countTwoStars: dictionary["countTwoStars"] as? Int ?? 0,
            countOneStars: dictionary["countOneStars"] as? Int ?? 0,
            countOfComments: dictionary["countOfComments"] as? Int ?? 0,
            comments: comments.compactMap { .init(dictionary: $0) }
        )
    }
}

// MARK: - Mapper

extension FBProductModel.FBProductReviewsModel {

    var mapper: ProductReviewsModel {
        ProductReviewsModel(
            countFiveStars: countFiveStars,
            countFourStars: countFourStars,
            countThreeStars: countThreeStars,
            countTwoStars: countTwoStars,
            countOneStars: countOneStars,
            countOfComments: countOfComments,
            comments: comments.mapper
        )
    }
}

extension FBProductModel.FBProductReviewsModel: Equatable {

    static func == (
        lhs: FBProductModel.FBProductReviewsModel,
        rhs: FBProductModel.FBProductReviewsModel
    ) -> Bool {
        guard lhs.countFiveStars  == rhs.countFiveStars,
              lhs.countFourStars  == rhs.countFourStars,
              lhs.countThreeStars == rhs.countThreeStars,
              lhs.countTwoStars   == rhs.countTwoStars,
              lhs.countOneStars   == rhs.countOneStars,
              lhs.countOfComments == rhs.countOfComments,
              lhs.comments.count  == rhs.comments.count
        else {
            return false
        }

        return zip(lhs.comments, rhs.comments).allSatisfy { $0 == $1 }
    }
}
