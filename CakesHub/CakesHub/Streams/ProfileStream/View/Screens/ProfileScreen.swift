//
//  ProfileScreen.swift
//  CakesHub
//
//  Created by Milana Shakhbieva on 22.03.2024.
//

import SwiftUI

struct ProfileScreen: View {
    typealias ViewModel = ProfileViewModel

    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var nav: Navigation

    init(viewModel: ViewModel = ViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        MainView
            .navigationDestination(for: ViewModel.Screens.self) { screen in
                switch screen {
                case .message:
                    let vm = ChatViewModel(user: viewModel.user)
                    ChatView(viewModel: vm)
                case .notifications:
                    Text("Экран уведомлений")
                case .settings:
                    SettingsView()
                }
            }
    }
}

// MARK: - Actions

extension ProfileScreen {

    /// Нажатие на кнопку открытия чата
    func didTapOpenMessageScreen() {
        nav.addScreen(screen: ViewModel.Screens.message)
    }

    /// Нажатие на кнопку открытия настроек
    func didTapOpenSettings() {
        nav.addScreen(screen: ViewModel.Screens.settings)
    }

    /// Нажатие на кнопку открытия уведомлений
    func didTapOpenNotifications() {
        nav.addScreen(screen: ViewModel.Screens.notifications)
    }

    /// Нажали на карточку товара
    func didTapProductCard(product: ProductModel) {
        nav.addScreen(screen: product)
    }

    /// Нажали на лайк карточки товара
    func didTapProductLikeButton(for uid: UUID, isSelected: Bool) {
        Logger.log(message: "Нажали лайк \(uid): \(isSelected)")
    }
}

// MARK: - Preview

#Preview {
    ProfileScreen(viewModel: .mockData)
        .environmentObject(Navigation())
}
