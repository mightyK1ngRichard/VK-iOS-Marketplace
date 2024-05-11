//
//  ChatView.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 26.03.2024.
//  Copyright 2024 © VKxBMSTU Team CakesHub. All rights reserved.
//

import SwiftUI

struct ChatView: View, ViewModelable {
    typealias ViewModel = ChatViewModel

    @EnvironmentObject private var nav: Navigation
    @State var viewModel: ViewModel
    @State var messageText: String = .clear

    var body: some View {
        MainView
            .onReceive(
                NotificationCenter.default.publisher(for: .WebSocketNames.message)
            ) { output in
                viewModel.receivedMessage(output: output)
            }
    }
}

// MARK: - Actions

extension ChatView {
    
    /// Нажали кнопку `отправить` сообщение
    func didTapSendMessageButton() {
        viewModel.sendMessage(message: messageText)
        messageText = .clear
    }
}

// MARK: - Preview

#Preview {
    ChatView(viewModel: .mockData)
        .environmentObject(Navigation())
}
