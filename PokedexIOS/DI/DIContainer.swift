//
//  DIContainer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct DIContainer<T>: DynamicProperty {
    
    @Environment(\.diContainer) public var container
    
    public init() {}
    
    public var wrappedValue: T {
        value
    }
    
    public var value: T {
        container.resolve()
    }
}
