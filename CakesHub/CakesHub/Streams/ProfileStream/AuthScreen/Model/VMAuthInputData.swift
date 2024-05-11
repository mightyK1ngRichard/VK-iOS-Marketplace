//
//  UserInputData.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 13.04.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import Foundation

extension AuthViewModel {

    struct VMAuthInputData: ClearConfigurationProtocol {
        var nickName: String
        var password: String
        var email: String

        static let clear = VMAuthInputData(nickName: .clear, password: .clear, email: .clear)
    }
}

// MARK: - Mapper

extension AuthViewModel.VMAuthInputData {

    var mapper: RegisterUserRequest {
        RegisterUserRequest(nickname: nickName, email: email, password: password)
    }
}
