//
//  Optional+Extenstions.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 13/11/2023.
//  Copyright 2023 © VK Team CakesHub. All rights reserved.
//

import Foundation

extension Optional<String> {
    
    /// Если строка пустая или nil, вернём nil
    var emptyOrNilToString: String? {
        guard let self else { return nil }
        return self.isEmpty ? nil : self
    }
}
