//
//  DIContainer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

class Container {
    var factory: [String: () -> Any]
    var store: [String: Any]
    
    init() {
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
}

struct ContainerKey: EnvironmentKey {
    static var defaultValue: Container = .init()
}

extension EnvironmentValues {
    var container: Container {
        get { self[ContainerKey.self] }
        set { self[ContainerKey.self] =  newValue }
    }
}
