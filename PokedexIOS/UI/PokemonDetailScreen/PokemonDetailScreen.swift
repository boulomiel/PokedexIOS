//
//  PokemonDetailScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI
import Tools
import DI

public struct PokemonDetailScreen: View {
    
    @DIContainer var fetchPokemonApi: FetchPokemonApi
    @DIContainer var evolutionChainApi: PokemonEvolutionChainApi
    @State var provider: PokemonDetailsProvider
    @State var isStatsExpanded: Bool = true
    @State var isTestsExpanded: Bool = true
    @State var areDescriptionsExpanded: Bool = true
    @State var areMovesExpanded: Bool = true

    public var body: some View {
        List {

            Section("Generation") {
                segmentedGenView
                HStack {
                    Spacer()
                    genSprite
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)

            
            if let evolutionViewProvider = provider.evolutionViewProvider {
                Section("Evolutions") {
                    EvolutionListView(provider: evolutionViewProvider)
                }
                .listRowBackground(Color.clear)

            }
            
            if let speciesProvider = provider.speciesProvider {
                Section("Species") {
                    VarietiesListView(provider: speciesProvider) { pokemon in
                        EvolutionListViewCell(provider: .init(api: provider.fetchPokemonApi, pokemon: pokemon))
                    }
                }
                .listRowBackground(Color.clear)

            }
            
            if let abilityProvider = provider.abilityProvider {
                Section("Abilities") {
                    PokemonListAbilityView(provider: abilityProvider)
                }
                .listRowBackground(Color.clear)

            }
        
            Section("Statistics", isExpanded: $isStatsExpanded) {
                HStack {
                    Spacer()
                    statView
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)

            NavigationLink("Moves", value: MoveRoute(moveData: provider.moveData))
                .listRowBackground(Color.clear)

            NavigationLink("Descriptions", value: DescriptionRoute(values: provider.descriptionsByVersions))
                .listRowBackground(Color.clear)

        }
        .listStyle(.sidebar)
        .navigationTitle(provider.localPokemon.name.capitalized)
        .preferredColorScheme(.dark)
        .toolbarBackground(.hidden, for: .navigationBar)
        .pokemonTypeBackgroundV(types: provider.pokemon?.types.pt ?? [])
        .scrollContentBackground(.hidden)
        .environment(provider)
    }
    
    @ViewBuilder
    var segmentedGenView: some View {
        if let segmentProvider = provider.segmentProvider {
            PokemonGenerationSegmentView(provider: segmentProvider) 
        }
    }
    
    @ViewBuilder
    var genSprite: some View {
        if let url = provider.selectedSegmentURL {
            ScaleAsyncImage(url: url, width: isStatsExpanded ? 200: 300, height: isStatsExpanded ? 200: 300)
        }
    }
    
    var statView: some View {
        PokemonStatsView(
            pokemonStats: provider.stats,
            backgroundColor: .white.opacity(
                0.2
            ),
            dataColor: .blue,
            strokeLine: .blue
        )
        .padding(.vertical, 15)
    }
}

#Preview {
    let preview = Preview.allPreview
    @Environment(\.diContainer) var container
    
    return RootView()
        .inject(container: container)
        .modelContainer(preview.container)
}
