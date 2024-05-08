//
//  DIContainer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import SwiftData

public class Container {
    var factory: [String: () -> Any]
    var store: [String: Any]
    let swiftDataController: SwiftDataController
    var modelContainer: ModelContainer
    
    public init() {
        print(#file, #function)
        swiftDataController = .init(models: SDTeam.self, SDPokemon.self, SDMove.self, SDItem.self, SDAbility.self, SDSpecies.self, SDLanguagePokemonName.self, SDLanguageItemName.self, isTesting: false)
        self.modelContainer = swiftDataController.container
        self.store = [:]
        self.factory = [:]
    }

    public func registration(register: @escaping ((Container) -> Void)) {
        register(self)
    }
    
    public func register<T>(_ type: T.Type, object: T, with container: ((Container) -> Void)? = nil) {
        factory[String(describing: T.self)] = {
            object
        }
        store[String(describing: T.self)] = factory[String(describing: T.self)]?()
        container?(self)
    }
    
    public func resolve<T>() -> T {
        guard let resolved = store[String(describing: T.self)] as? T else {
            fatalError("\(T.self) has not been registered yet !")
        }
        return resolved
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        guard let resolved = store[String(describing: T.self)] as? T else {
            fatalError("\(T.self) has not been registered yet !")
        }
        return resolved
    }
}

public struct ContainerKey: EnvironmentKey {
    public static var defaultValue: Container = .init()
}

public extension EnvironmentValues {
    var diContainer: Container {
        get { self[ContainerKey.self] }
        set { self[ContainerKey.self] =  newValue }
    }
}
