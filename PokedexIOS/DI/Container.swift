//
//  DIContainer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import SwiftData

class Container {
    var factory: [String: () -> Any]
    var store: [String: Any]
    let swiftDataController: SwiftDataController
    var modelContainer: ModelContainer
    
    init() {
        print(#file, #function)
        swiftDataController = .init(models: SDTeam.self, SDPokemon.self, SDMove.self, SDItem.self, SDAbility.self, SDSpecies.self, SDLanguagePokemonName.self, SDLanguageItemName.self, isTesting: false)
        self.modelContainer = swiftDataController.container
        self.store = [:]
        self.factory = [:]
    }

    func registration(register: @escaping ((Container) -> Void)) {
        register(self)
    }
    
    func register<T>(_ type: T.Type, object: T, with container: ((Container) -> Void)? = nil) {
        factory[String(describing: T.self)] = {
            object
        }
        store[String(describing: T.self)] = factory[String(describing: T.self)]?()
        container?(self)
    }
    
    func resolve<T>() -> T {
        guard let resolved = store[String(describing: T.self)] as? T else {
            fatalError("\(T.self) has not been registered yet !")
        }
        return resolved
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let resolved = store[String(describing: T.self)] as? T else {
            fatalError("\(T.self) has not been registered yet !")
        }
        return resolved
    }
}

struct ContainerKey: EnvironmentKey {
    static var defaultValue: Container = .init()
}

extension EnvironmentValues {
    var diContainer: Container {
        get { self[ContainerKey.self] }
        set { self[ContainerKey.self] =  newValue }
    }
}
