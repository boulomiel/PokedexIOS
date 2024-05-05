//
//  DIContainer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

@propertyWrapper
struct DIContainer<T>: DynamicProperty {
    
    @Environment(\.container) var container
    
    var wrappedValue: T {
        value
    }
    
    var value: T {
        container.resolve()
    }
}
