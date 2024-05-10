//
//  PokedexScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftUI
import Tools
import DI

public struct PokedexScreen: View {
    
    @DIContainer private var fetchApi: FetchPokemonApi
    @DIContainer private var speciesApi: PokemonSpeciesApi
    @DIContainer private var player: CriePlayer
    @DIContainer private var evolutionChainApi: PokemonEvolutionChainApi
    @DIContainer private var abilitiesApi: PokemonAbilityApi
    
    public var body: some View {
        NavigationStack {
            PokemonScrollScreen()
                .navigationDestination(for: LocalPokemon.self) { pokemon in
                    PokemonDetailScreen(provider: .init(api: fetchApi,speciesApi: speciesApi, evolutionChainApi: evolutionChainApi, abilitiesApi: abilitiesApi, localPokemon: pokemon, player: player))
                        .networkedContentView()
                }
                .navigationDestination(for: MoveRoute.self) { route in
                    MoveScreen(provider: .init(moveData: route.moveData))
                        .networkedContentView()
                }
                .navigationDestination(for: DescriptionRoute.self) { route in
                    if let description = route.values.first {
                        DescriptionScreen(descriptions: route.values, selectedLanguage: description.language)
                            .networkedContentView()
                    }
                }
                .navigationDestination(for: MoveDetailsRoute.self) { route in
                    PokemonMoveDetailsScreen(move: route.move)
                        .networkedContentView()
                }
                .showMutableIcon()
        }
        .preferredColorScheme(.dark)
        .networkedContentView()
    }
}

#Preview {
    @Environment(\.diContainer) var container
    
    return PokedexScreen()
        .inject(container: container)
}
