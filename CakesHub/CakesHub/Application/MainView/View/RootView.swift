//
//  RootView.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 08.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI
import SwiftData

struct RootView: View {

    @StateObject private var nav = Navigation()
    @StateObject var viewModel = RootViewModel()
    @Environment(\.modelContext) private var context
    @State private var size: CGSize = .zero

    var body: some View {
        NavigationStack(path: $nav.path) {
            AuthOrMainView
        }
        .tint(CHMColor<IconPalette>.navigationBackButton.color)
        .environmentObject(nav)
        .environmentObject(viewModel)
        .viewSize(size: $size)
        .onAppear(perform: onAppear)
    }
}

// MARK: - Network

private extension RootView {

    func onAppear() {
        viewModel.setContext(context: context)
        Task {
            do {
                try await viewModel.fetchData()
            } catch {
                viewModel.fetchDataWithoutNetwork()
                Logger.log(kind: .error, message: error.localizedDescription)
            }
        }
    }
}

// MARK: - UI Subviews

private extension RootView {

    @ViewBuilder
    var AuthOrMainView: some View {
        if viewModel.isAuth {
            MainViewBlock
        } else {
            AuthView()
        }
    }

    var MainViewBlock: some View {
        ZStack(alignment: .bottom) {
            AllTabBarViews
            CustomTabBarView()
        }
        .navigationDestination(for: ProductModel.self) { card in
            let vm = ProductDetailViewModel(data: card)
            ProductDetailScreen(viewModel: vm)
        }
        .navigationDestination(for: UserModel.self) { user in
            let vm = ProfileViewModel(user: user)
            ProfileScreen(viewModel: vm)
        }
    }

    @ViewBuilder
    var AllTabBarViews: some View {
        switch nav.activeTab {
        case .house:
            MainView(size: size)
        case .categories:
            CategoriesView()
        case .chat:
            AllChatsView()
        case .notifications:
            NotificationView()
        case .profile:
            let fbUser = viewModel.currentUser
            let sellerInfo = fbUser.mapper
            let userProducts = viewModel.productData.currentUserProducts.mapperToProductModel
            let userModel = sellerInfo.mapper(products: userProducts)
            ProfileScreen(viewModel: .init(user: userModel))
        }
    }
}

// MARK: - Preview

#Preview {
    RootView()
        .environmentObject(Navigation())
        .environmentObject(RootViewModel.mockData)
        .modelContainer(
            Preview(
                SDProductModel.self,
                SDNotificationModel.self,
                SDChatMessageModel.self,
                SDCategoryModel.self
            ).container
        )
}













































