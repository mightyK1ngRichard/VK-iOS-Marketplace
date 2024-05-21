//
//  SettingsSubiew.swift
//  CakesHub
//
//  Created by Milana Shakhbieva on 26.03.2024.
//  Copyright 2024 © VKxBMSTU Team CakesHub. All rights reserved.
//

import SwiftUI

extension SettingsView {
    
    var MainView: some View {
        List {
            Group {
                PersonalSection

                NotificationSection

                DocumentsSection

                ButtonsBlock
            }
            .listRowBackground(Constants.rowColor)
        }
        .sheet(isPresented: $viewModel.uiProperties.openSheet, onDismiss: {
            viewModel.uiProperties.selectedScreen = nil
        }) {
            ZStack(alignment: .top) {
                switch viewModel.uiProperties.selectedScreen {
                case .updatePassword:
                    EditPasswordView()
                case .updateEmail:
                    EditEmailView()
                case .none:
                    Text("Error")
                }

                RoundedRectangle(cornerRadius: 3)
                    .fill(CHMColor<SeparatorPalette>.divider.color)
                    .frame(width: 60, height: 6)
                    .offset(y: 15)
            }
            .presentationDetents([.medium])
            .presentationCornerRadius(12)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Settings")
        .background(Constants.bgColor)
    }

    var PersonalSection: some View {
        Section(header: Text("Personal information")) {
            NavigationLink(
                destination: EditProfileView().environmentObject(profileVM)
            ) {
                Label("Profile", systemImage: "person")
                    .foregroundColor(Constants.textColor)
            }

            Button(action: {
                viewModel.uiProperties.selectedScreen = .updatePassword
                viewModel.uiProperties.openSheet = true
            }) {
                Label("Password", systemImage: "lock")
                    .foregroundColor(Constants.textColor)
            }

            Button(action: {
                viewModel.uiProperties.selectedScreen = .updateEmail
                viewModel.uiProperties.openSheet = true
            }) {
                Label("Mail", systemImage: "envelope")
                    .foregroundColor(Constants.textColor)
            }
            
            Button(action: {
                viewModel.uiProperties.showAlert = true
            }) {
                Label("Delete account", systemImage: "trash")
                    .foregroundColor(Constants.deleteColor)
            }
            .alert(isPresented: $viewModel.uiProperties.showAlert) {
                Alert(
                    title: Text(String(localized: "Do you really want to delete your account?")),
                    primaryButton: .destructive(Text(String(localized: "Yes"))) {
                        viewModel.didTapDeleteAccount()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    var NotificationSection: some View {
        Section(header: Text("Notifications")) {
            NavigationLink(destination: NotificationsView()) {
                Label("Notifications", systemImage: "bell")
                    .foregroundColor(Constants.textColor)
            }
        }
    }

    var DocumentsSection: some View {
        Section(header: Text("Documents")) {
            Button(action: {
                if let url = URL(string: "https://www.apple.com/ru/legal/privacy/ru/") {
                    UIApplication.shared.open(url)
                }
            }) {
                Label("Privacy Policy", systemImage: "doc.text")
                    .foregroundColor(Constants.textColor)
            }

            Button(action: {
                if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/ru/terms.html") {
                    UIApplication.shared.open(url)
                }
            }) {
                Label("User Agreement", systemImage: "doc.text")
                    .foregroundColor(Constants.textColor)
            }
        }
    }

    @ViewBuilder
    var ButtonsBlock: some View {
        Button(action: {
            guard let url = URL(string: "https://t.me/ms_shakhbieva") else {
                return
            }
            UIApplication.shared.open(url)
        }) {
            Label("Support", systemImage: "questionmark.circle")
        }

        Button(action: viewModel.didTapSignOutButton, label: {
            Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                .foregroundStyle(Constants.deleteColor)
        })
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SettingsView(viewModel: .mockData)
    }
    .environmentObject(Navigation())
    .environmentObject(RootViewModel.mockData)
}

// MARK: - Constants

private extension SettingsView {

    enum Constants {
        static let textColor = CHMColor<TextPalette>.textPrimary.color
        static let deleteColor = CHMColor<TextPalette>.textWild.color
        static let userMailColor = CHMColor<TextPalette>.textPrimary.color
        static let bgColor = CHMColor<BackgroundPalette>.bgMainColor.color
        static let rowColor = CHMColor<BackgroundPalette>.bgCommentView.color
    }
}
