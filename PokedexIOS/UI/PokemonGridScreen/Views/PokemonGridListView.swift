//
//  PokemonGridListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import SwiftUI

struct PokemonGridListView: View {
    @DIContainer var fetchApi: FetchPokemonApi
    let provider: Provider
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: provider.gridItems, content: {
                ForEach(provider.providers, id: \.id) { provider in
                    PokemonGridCell(provider: provider)
                }
            })
        }
    }
    
    @Observable
    class Provider {
        let pokemons: [String]
        let gridItems: [GridItem]
        var providers: [PokemonGridCell.Provider]
        
        init(fetchApi: FetchPokemonApi, pokemons: [String], gridItems: [GridItem] = []) {
            self.pokemons = pokemons
            self.gridItems = .init(repeating: .init(.fixed(120)), count: 3)
            self.providers = pokemons.map { name in
                    .init(pokemon: name, fechPokemonApi: fetchApi)
            }
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    
    return PokemonGridListView(provider: .init(fetchApi: .init(), pokemons: ["gengar", "pikachu", "raichu", "mew", "lugia","charmander","gastly"]))
        .preferredColorScheme(.dark)
        .inject(container: container)
}
