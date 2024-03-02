//
//  UserRequest.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//

import Foundation

final class UserRequest {
    let name: String
    let login: String
    let password: String
    let image: String?
    let phone: String

    init(name: String, login: String, password: String, image: String?, phone: String) {
        self.name = name
        self.login = login
        self.password = password
        self.image = image
        self.phone = phone
    }
}
