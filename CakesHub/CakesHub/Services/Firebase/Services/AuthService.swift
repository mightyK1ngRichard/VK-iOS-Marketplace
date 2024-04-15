//
//  AuthService.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 02.03.2024.
//

import Foundation
import FirebaseAuth

// MARK: - AuthServiceProtocol

protocol AuthServiceProtocol: AnyObject {
    func registeUser(with userRequest: RegisterUserRequest) async throws -> String
    func loginUser(with userRequest: LoginUserRequest) async throws -> String
    func logoutUser() throws
    func deleteUser() async throws
}

// MARK: - AuthService

final class AuthService {

    static var shared = AuthService()
    private var auth = Auth.auth()

    private init() {}
}

// MARK: - Methods

extension AuthService: AuthServiceProtocol {

    func registeUser(with userRequest: RegisterUserRequest) async throws -> String {
        let result = try await auth.createUser(withEmail: userRequest.email, password: userRequest.password)
        let uid = result.user.uid
        let createdUser = UserRequest(uid: uid, nickname: userRequest.nickname, email: userRequest.email)
        try await UserService.shared.createUserInfo(for: createdUser)
        return uid
    }

    func loginUser(with userRequest: LoginUserRequest) async throws -> String {
        let result = try await auth.signIn(withEmail: userRequest.email, password: userRequest.password)
        let userUID = result.user.uid
        return userUID
    }

    func logoutUser() throws {
        try auth.signOut()
    }

    func deleteUser() async throws {
        guard let currentUser = auth.currentUser else {
            throw APIError.userIsNil
        }
        
        try await currentUser.delete()
    }
}
