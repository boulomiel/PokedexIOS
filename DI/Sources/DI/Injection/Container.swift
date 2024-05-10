//
//  DIContainer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import SwiftData
import Tools
import Resources
import ShareTeam
import Dtos

public class Container {
    var factory: [String: () -> Any]
    var store: [String: Any]
    let swiftDataController: SwiftDataController
    
    public var modelContainer: ModelContainer {
        swiftDataController.container
    }
    
    public init() {
        print(#file, #function)
        swiftDataController = .init(
            models: SDTeam.self,
            SDPokemon.self,
            SDMove.self,
            SDItem.self,
            SDAbility.self,
            SDSpecies.self,
            SDLanguagePokemonName.self,
            SDLanguageItemName.self,
            SDShareUser.self,
            isTesting: false
        )
        self.store = [:]
        self.factory = [:]
        inject()
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

fileprivate extension Container {
    func inject() {
        
        let scrollFetchGeneralApi = GeneralApi<ScrollFetchResult>()
        let fetchPokemonApi = FetchPokemonApi()
        let pokemonSpeciesApi = PokemonSpeciesApi()
        let pokemonItemApi = PokemonItemApi()
        
        // APIs
        registration { container in
            container.register(ScrollFetchPokemonApi.self, object: .init())
            container.register(FetchPokemonApi.self, object: fetchPokemonApi)
            container.register(PokemonAbilityApi.self, object: .init())
            container.register(PokemonSpeciesApi.self, object:  pokemonSpeciesApi)
            container.register(PokemonEvolutionChainApi.self, object: .init())
            container.register(PokemonMoveApi.self, object: .init())
            container.register(PokemonMachineApi.self, object: .init())
            container.register(GeneralApi<Machine>.self, object: .init())
            container.register(GeneralApi<ItemCategories>.self, object: .init())
            container.register(GeneralApi<ScrollFetchResult>.self, object: scrollFetchGeneralApi)
            container.register(PokemonNatureApi.self, object: .init())
            container.register(PokemonItemApi.self, object: pokemonItemApi)
            container.register(ScrollFetchItemApi.self, object: .init())
            container.register(PokemonCategoryItemApi.self, object: .init())
        }
        
        // Caches
        let imageCache = ImageCache()
        register(ImageCache.self, object: imageCache, with: nil)
        
        //NetworkManager
        register(NetworkManager.self, object: .init())
        
        //Player
        register(CriePlayer.self, object: .init())
        
        //LanguageNameFetcher
        register(LanguageNameFetcher.self, object: .init(container: modelContainer))
        
        //NamedDataLauncher
        registration { container in
            container.register(PokemonNameLauncherImpl.self, object: .init(apiEnv: PlistReader.read(list: .pokemonapi), api: scrollFetchGeneralApi, speciesApi: pokemonSpeciesApi))
            container.register(ItemNameLauncherImpl.self, object: .init(apiEnv: PlistReader.read(list: .pokemonapi), api: scrollFetchGeneralApi, itemApi: pokemonItemApi))
        }
        
        //Launcher
        let nameLaunchers: [any NameLauncherProtocol] = [resolve(PokemonNameLauncherImpl.self), resolve(ItemNameLauncherImpl.self)]
        register(AppLaunchWorker.self, object: .init(namedLauncherWorkers: nameLaunchers, container: modelContainer))
        
        //Sharing
        register(ShareSession.self, object: .init())
    }
}
