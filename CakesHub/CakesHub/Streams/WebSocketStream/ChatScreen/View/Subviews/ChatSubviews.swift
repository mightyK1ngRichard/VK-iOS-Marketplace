//
//  ChatSubviews.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 27.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI


// MARK: - Subviews

extension ChatView {

    var MainView: some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottom) {
                ScrollView {
                    MessagesBlock

                    HStack { Spacer() }
                        .id(Constants.scrollIdentifier)
                        .padding(.bottom, 50)
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                }

                TextFieldBlock
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial)
            }
            .frame(maxHeight: .infinity)
            .background {
                BackgroundView
                    .ignoresSafeArea()
            }
            .onAppear {
                // MARK: Закомментировать для работы превью.
                proxy.scrollTo(Constants.scrollIdentifier, anchor: .bottom)
            }
            .onChange(of: viewModel.data.lastMessageID) { _, _ in
                withAnimation {
                    proxy.scrollTo(Constants.scrollIdentifier, anchor: .bottom)
                }
            }
        }
    }

    var MessagesBlock: some View {
        LazyVStack {
            ForEach(viewModel.data.messages) { message in
                MessageBubble(message: message)
                    .padding(.horizontal, 8)
            }
        }
        .padding(.bottom, 50)
    }

    var BackgroundView: some View {
        LinearGradient(
            colors: Constants.gradientBackgroundColor,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .mask {
            Constants.tgBackground
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    var TextFieldBlock: some View {
        HStack {
            Constants.paperClip

            TextField(Constants.placeholder, text: $messageText)
                .padding(.vertical, 6)
                .padding(.horizontal, 13)
                .background(Constants.textFieldBackgroundColor, in: .rect(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                        .fill(Constants.textFieldStrokeColor)
                }

            if messageText.isEmpty {
                Constants.record
                    .frame(width: 22, height: 22)

            } else {
                Button(action: didTapSendMessageButton, label: {
                    Image(systemName: Constants.paperplane)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Constants.iconColor)
                })
            }
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Constants

private extension ChatView {

    enum Constants {
        static let scrollIdentifier = "EMPTY"
        static let imageSize: CGFloat = 200
        static let imageCornerRadius: CGFloat = 20
        static let tgBackground = Image("tg_layer")
        static let paperClip = Image("paperClip")
        static let record = Image("record")
        static let messageBackgroundColor = Color(red: 103/255, green: 77/255, blue: 122/255)
        static let textColor: Color = CHMColor<TextPalette>.textPrimary.color
        static let textFieldBackgroundColor = CHMColor<BackgroundPalette>.bgPrimary.color
        static let textFieldStrokeColor = CHMColor<SeparatorPalette>(hexLight: 0xD1D1D1, hexDark: 0x3A3A3C).color
        static let iconColor = Color(red: 127/255, green: 127/255, blue: 127/255)
        static let placeholder = "Message"
        static let paperplane = "paperplane"
        static let gradientBackgroundColor: [Color] = [
            Color(red: 168/255, green: 255/255, blue: 59/255),
            Color(red: 111/255, green: 135/255, blue: 255/255),
            Color(red: 215/255, green: 161/255, blue: 255/255),
            Color(red: 113/255, green: 190/255, blue: 255/255),
        ]
    }
}

// MARK: - Preview

#Preview {
    ChatView(viewModel: .mockData)
}
