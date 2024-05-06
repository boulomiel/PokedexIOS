//
//  PokemonDetailScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI

struct PokemonDetailScreen: View {
    
    @DIContainer var fetchPokemonApi: FetchPokemonApi
    @DIContainer var evolutionChainApi: PokemonEvolutionChainApi
    @State var provider: PokemonDetailsProvider
    @State var isStatsExpanded: Bool = true
    @State var isTestsExpanded: Bool = true
    @State var areDescriptionsExpanded: Bool = true
    @State var areMovesExpanded: Bool = true

    var body: some View {
        List {
            Section("Generation") {
                segmentedGenView
                HStack {
                    Spacer()
                    genSprite
                    Spacer()
                }
            }
            
            if let evolutionViewProvider = provider.evolutionViewProvider {
                Section("Evolutions") {
                    EvolutionListView(provider: evolutionViewProvider)
                }
            }
            
            if let speciesProvider = provider.speciesProvider {
                Section("Species") {
                    VarietiesListView(provider: speciesProvider) { pokemon in
                        EvolutionListViewCell(provider: .init(api: provider.fetchPokemonApi, pokemon: pokemon))
                    }
                }
            }
            
            if let abilityProvider = provider.abilityProvider {
                Section("Abilities") {
                    PokemonListAbilityView(provider: abilityProvider)
                }
            }
        
            Section("Statistics", isExpanded: $isStatsExpanded) {
                statView
            }
            NavigationLink("Moves", value: MoveRoute(moveData: provider.moveData))
            NavigationLink("Descriptions", value: DescriptionRoute(values: provider.descriptionsByVersions))
        }
        .listStyle(.sidebar)
        .navigationTitle(provider.localPokemon.name.capitalized)
        .preferredColorScheme(.dark)
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
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .modelContainer(preview.container)
}
