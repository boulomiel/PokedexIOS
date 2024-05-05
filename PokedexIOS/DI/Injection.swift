//
//  Injection.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

struct InjectModifier: ViewModifier, DynamicProperty {
    
    let container : Container
    
    init(container: Container) {
        self.container = container
        self.container.inject()
    }
    
    func body(content: Content) -> some View {
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
        // APIs
        registration { container in
            container.register(ScrollFetchPokemonApi.self, object: .init())
            container.register(FetchPokemonApi.self, object: .init())
            container.register(PokemonAbilityApi.self, object: .init())
            container.register(PokemonSpeciesApi.self, object: .init())
            container.register(PokemonEvolutionChainApi.self, object: .init())
            container.register(PokemonMoveApi.self, object: .init())
            container.register(PokemonMachineApi.self, object: .init())
            container.register(GeneralApi<Machine>.self, object: .init())
            container.register(GeneralApi<ItemCategories>.self, object: .init())
            container.register(GeneralApi<NamedAPIResource>.self, object: .init())
            container.register(PokemonNatureApi.self, object: .init())
            container.register(PokemonItemApi.self, object: .init())
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
    }
}
