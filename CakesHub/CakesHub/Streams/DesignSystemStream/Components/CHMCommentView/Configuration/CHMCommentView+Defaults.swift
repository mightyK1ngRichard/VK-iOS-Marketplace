//
//  CHMCommentView+Defaults.swift
//  CHMUIKIT
//
//  Created by Dmitriy Permyakov on 27.01.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import Foundation

extension CHMCommentView.Configuration {

    /// Basic configuration
    static let clear = CHMCommentView.Configuration()

    /// Basic configuration
    /// - Parameters:
    ///   - imageKind: image kind
    ///   - userName: user name
    ///   - date: date info
    ///   - description: comment description
    ///   - starsConfiguration: stars view configuration
    /// - Returns: configuration of the view
    static func basic(
        imageKind: ImageKind,
        userName: String,
        date: String,
        description: String,
        starsConfiguration: CHMStarsView.Configuration
    ) -> Self {
        modify(.clear) {
            $0.userImageConfiguration = .imageConfiguration(imageKind)
            $0.userName = userName
            $0.date = date
            $0.description = description
            $0.starsConfiguration = starsConfiguration
        }
    }
}

// MARK: - MKRImageView Configuration

private extension MKRImageView.Configuration {

    static func imageConfiguration(_ kind: ImageKind) -> Self {
        .basic(
            kind: kind,
            imageShape: .capsule
        )
    }
}
