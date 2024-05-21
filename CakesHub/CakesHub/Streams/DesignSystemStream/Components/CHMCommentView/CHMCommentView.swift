//
//  CHMCommentView.swift
//  CHMUIKIT
//
//  Created by Dmitriy Permyakov on 27.01.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI

/**
 Component `CHMCommentView`

 For example:
 ```swift
 let view = CHMCommentView(
     configuration: .constant(
         .basic(
             imageKind: .url(.url),
             userName: "Helene Moore",
             date: "June 5, 2019",
             description: "Описание",
             starsConfiguration: .basic(kind: .four, feedbackCount: 21)
         )
     )
 )
 ```
*/
struct CHMCommentView: View {
    
    let configuration: Configuration

    var body: some View {
        VStack(alignment: .leading) {
            Text(configuration.userName)
                .userNameFont
            
            StarsBlock
            
            Text(configuration.description)
                .descriptionFont
                .padding(.top, 11)
        }
        .padding(EdgeInsets(top: 23, leading: 24, bottom: 33, trailing: 20))
        .background(CHMColor<BackgroundPalette>.bgCommentView.color)
        .clipShape(.rect(cornerRadius: 8))
        .overlay(alignment: .topLeading) {
            MKRImageView(configuration: configuration.userImageConfiguration)
                .frame(width: 32, height: 32)
                .offset(x: -16, y: -16)
        }
        .padding([.leading, .top], 16)
    }
}

// MARK: - Subviews

private extension CHMCommentView {
    
    var StarsBlock: some View {
        HStack {
            CHMStarsView(configuration: configuration.starsConfiguration)

            Spacer()

            Text(configuration.date)
                .dateFont
        }
    }
}

// MARK: - Text

private extension Text {
    
    var userNameFont: some View {
        self
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(CHMColor<TextPalette>.textPrimary.color)
    }
    
    var descriptionFont: some View {
        self
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(CHMColor<TextPalette>.textDescription.color)
            .lineSpacing(8)
    }
    
    var dateFont: some View {
        self
            .font(.system(size: 11, weight: .regular))
            .foregroundStyle(CHMColor<TextPalette>.textSecondary.color)
    }
}

// MARK: - Preview

#Preview {
    CHMCommentView(
        configuration: .basic(
            imageKind: .uiImage(.mockUser),
            userName: "Helene Moore",
            date: "June 5, 2019",
            description: """
            The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7" and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.
            """,
            starsConfiguration: .basic(kind: .four, feedbackCount: 21)
        )
    )
}
