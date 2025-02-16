//
//  PokemonGridListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import SwiftUI
import DI

public struct PokemonGridListView: View {
    @DIContainer var fetchApi: FetchPokemonApi
    let provider: Provider
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: provider.gridItems, content: {
                ForEach(provider.providers, id: \.id) { provider in
                    PokemonGridCell(provider: provider)
                }
            })
        }
        .padding()
        .loadable(isLoading: provider.providers.isEmpty)
    }
    
    @Observable @MainActor
    public class Provider {
        typealias CellProvider = PokemonGridCell.Provider
        let pokemons: [String]
        let gridItems: [GridItem]
        var providers: [CellProvider]
        
        init(
            fetchApi: FetchPokemonApi,
            pokemons: [String],
            gridItems: [GridItem] = .init(
                repeating: .init(
                    .adaptive(
                        minimum: 120
                    )
                ),
                count: 3
            )
        ) {
            self.pokemons = pokemons
            self.gridItems = gridItems
            self.providers = []
            makeProviders(fetchApi: fetchApi)
        }
        
        private func makeProviders(fetchApi: FetchPokemonApi) {
            Task {
                await withTaskGroup(of: CellProvider.self) { group in
                    pokemons.forEach { name in
                        group.addTask {
                            await PokemonGridCell.Provider(
                                pokemon: name,
                                fechPokemonApi: fetchApi
                            )
                        }
                    }
                    for await provider in group {
                        self.providers.append(provider)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    
    return PokemonGridListView(provider: .init(fetchApi: .init(), pokemons: ["gengar", "pikachu", "raichu", "mew", "lugia","charmander","gastly", "mewtwo", "venusaur", "charizard"]))
        .preferredColorScheme(.dark)
        .inject(container: container)
}
