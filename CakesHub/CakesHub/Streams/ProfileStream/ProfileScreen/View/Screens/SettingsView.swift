//
//  Settings.swift
//  CakesHub
//
//  Created by Milana Shakhbieva on 26.03.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {
        List {
            Section(header: Text("Персональные данные")) {
                NavigationLink(destination: EditProfileView()) {
                    Label("Редактировать профиль", systemImage: "person")
                        .foregroundColor(Constants.textColor)
                }
                NavigationLink(destination: Text("Введите новый пароль")) {
                    Label("Редактировать пароль", systemImage: "lock")
                        .foregroundColor(Constants.textColor)
                }
                NavigationLink(destination: Text("Введите новую почту")) {
                    Label("Почта", systemImage: "envelope")
                        .foregroundColor(Constants.textColor)
                }
                Button(action: {}) {
                    Label("Удалить аккаунт", systemImage: "trash")
                        .foregroundColor(Constants.deleteColor)
                }
            }

            Section(header: Text("Уведомлений")) {
                NavigationLink(destination: NotificationsView()) {
                    Label("Уведомления", systemImage: "bell")
                        .foregroundColor(Constants.textColor)
                }
            }

            Section(header: Text("Документы")) {
                NavigationLink(destination: Text("Политика конфиденциальности")) {
                    Label("Политика конфиденциальности", systemImage: "doc.text")
                        .foregroundColor(Constants.textColor)
                }
                NavigationLink(destination: Text("Пользовательское соглашение")) {
                    Label("Пользовательское соглашение", systemImage: "doc.text")
                        .foregroundColor(Constants.textColor)
                }
            }

            Button(action: {}) {
                Label("Support", systemImage: "questionmark.circle")
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Настройки")
        .background(Constants.bgColor)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SettingsView()
    }
}

// MARK: - Constants

private extension SettingsView {
    
    enum Constants {
        static let textColor = CHMColor<TextPalette>.textPrimary.color
        static let deleteColor = CHMColor<TextPalette>.textWild.color
        static let userMailColor = CHMColor<TextPalette>.textPrimary.color
        static let bgColor = CHMColor<BackgroundPalette>.bgMainColor.color
    }
}
