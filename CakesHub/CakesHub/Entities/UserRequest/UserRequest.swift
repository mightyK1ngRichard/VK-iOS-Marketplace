//
//  UserRequest.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//

import Foundation

struct UserRequest: DictionaryConvertible, ClearConfigurationProtocol {
    var id       : String = .clear
    var name     : String = .clear
    var login    : String = .clear
    var password : String = .clear
    var image    : String?
    var phone    : String = .clear

    static let clear = UserRequest()
}

// MARK: - MockData

#if DEBUG
extension UserRequest {

    static let mockData = UserRequest(
        id: "8n5di1sb8ya1I9Tc2uR8TWpgtsK2",
        name: RegisterUserRequest.mockData.nickname,
        login: RegisterUserRequest.mockData.email,
        password: RegisterUserRequest.mockData.password,
        image: "https://webmg.ru/wp-content/uploads/2022/10/i-321-1.jpeg",
        phone: "+7(914)234-12-12"
    )
}
#endif
