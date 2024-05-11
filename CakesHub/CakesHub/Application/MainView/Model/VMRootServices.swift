//
//  VMRootServices.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 19.04.2024.
//  Copyright 2024 © VK Team CakesHub. All rights reserved.
//

import Foundation

extension RootViewModel {

    struct Services: ClearConfigurationProtocol {
        let cakeService: CakeServiceProtocol
        let wbManager: WebSockerManagerProtocol

        init(
            cakeService: CakeServiceProtocol = CakeService.shared,
            wbManager: WebSockerManagerProtocol = WebSockerManager.shared
        ) {
            self.cakeService = cakeService
            self.wbManager = wbManager
        }

        static let clear: RootViewModel.Services = .init()
    }
}
