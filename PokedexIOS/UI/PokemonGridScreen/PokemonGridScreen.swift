//
//  PokemonGridScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import SwiftUI
import Tools
import DI

public struct PokemonGridScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @DIContainer var fetchPokemonApi: FetchPokemonApi
    @DIContainer var speciesApi: PokemonSpeciesApi
    @DIContainer var evolutionChainApi: PokemonEvolutionChainApi
    @DIContainer var abilitiesApi: PokemonAbilityApi
    @DIContainer var player: CriePlayer
    
    let provider: Provider
    
    public var body: some View {
        NavigationStack {
            PokemonGridListView(provider: .init(fetchApi: fetchPokemonApi, pokemons: provider.pokemons))
                .navigationDestination(for: LocalPokemon.self) { localPokemon in
                    PokemonDetailScreen(provider: .init(api: fetchPokemonApi, speciesApi: speciesApi, evolutionChainApi: evolutionChainApi, abilitiesApi: abilitiesApi, localPokemon: localPokemon, player: player))
                }
                .navigationTitle(provider.title ?? "")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss.callAsFunction()
                        }, label: {
                            Text("Close")
                        })
                    }
                }
        }
    }
    
    @Observable
   public class Provider {
        let pokemons: [String]
        let title: String?
        
        init(pokemons: [String], title: String? = nil) {
            self.pokemons = pokemons
            self.title = title
        }
    }
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    
    return PokemonGridScreen(provider: .init(pokemons: ["gengar", "pikachu", "raichu", "mew", "lugia"]))
        .inject(container: container)
        .preferredColorScheme(.dark)
}
