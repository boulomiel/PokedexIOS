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
    
    let container : Container
    
    init(container: Container) {
        self.container = container
        self.container.inject()
    }
    
    public func body(content: Content) -> some View {
        content
    }
}

extension View {
    func inject(container: Container) -> some View {
        modifier(InjectModifier(container: container))
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
        
        //NamedDataLauncher
        registration { container in
            container.register(PokemonNameLauncherImpl.self, object: .init(apiEnv: PlistReader.read(list: .pokemonapi), api: scrollFetchGeneralApi, speciesApi: pokemonSpeciesApi))
            container.register(ItemNameLauncherImpl.self, object: .init(apiEnv: PlistReader.read(list: .pokemonapi), api: scrollFetchGeneralApi, itemApi: pokemonItemApi))
        }
        
        //Launcher
        let nameLaunchers: [any NameLauncherProtocol] = [resolve(PokemonNameLauncherImpl.self), resolve(ItemNameLauncherImpl.self)]
        register(AppLaunchWorker.self, object: .init(namedLauncherWorkers: nameLaunchers, container: modelContainer))
    }
}
