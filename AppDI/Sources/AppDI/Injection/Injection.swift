//
//  Injection.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import Resources
import Tools

public struct InjectModifier: ViewModifier, DynamicProperty {
    
    @Environment(\.diContainer) var diContainer
    
    public func body(content: Content) -> some View {
        content
    }
}

public extension View {
    func inject(container: Container) -> some View {
        modifier(InjectModifier())
    }
}
