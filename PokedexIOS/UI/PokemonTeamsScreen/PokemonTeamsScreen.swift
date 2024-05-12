//
//  PokemonTeamsScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import SwiftData
import Resources
import Tools
import DI
import Dtos

public struct PokemonTeamsScreen: View {
    
    @Environment(\.modelContext)
    private var modelContext
    @DIContainer private var scrollFetchApi : ScrollFetchPokemonApi
    @DIContainer private var scrollFetchItemApi : ScrollFetchItemApi
    @DIContainer private var fetchApi: FetchPokemonApi
    @DIContainer private var movesApi: PokemonMoveApi
    @DIContainer private var abilityApi: PokemonAbilityApi
    @DIContainer private var speciesApi: PokemonSpeciesApi
    @DIContainer private var natureApi: PokemonNatureApi
    @DIContainer private var evolutionChainApi: PokemonEvolutionChainApi
    @DIContainer private var categoryItemApi: PokemonCategoryItemApi
    @DIContainer private var pokemonItemApi: PokemonItemApi
    @DIContainer private var generalApi: GeneralApi<ItemCategories>
    @DIContainer private var player: CriePlayer
    @DIContainer private var languageNameFetcher: LanguageNameFetcher

    @State var teamRouter: TeamRouter
    @State var teamCount: Int = 0
    
    public var body: some View {
        NavigationStack(path: $teamRouter.path) {
            PokemonTeamsListView()
                .navigationTitle("Teams")
                .navigationDestination(for: LocalPokemon.self, destination: { localPokemon in
                    PokemonDetailScreen(provider: .init(api: fetchApi, speciesApi: speciesApi, evolutionChainApi: evolutionChainApi, abilitiesApi: abilityApi , localPokemon: localPokemon, player: player))
                        .environment(teamRouter)
                        .networkedContentView()
                })
                .navigationDestination(for: AddTeamRoute.self) { route in
                    PaginatedList(provider: .init(api: scrollFetchApi, fetchApi: fetchApi, modelContainer: modelContext.container, languageNameFetcher: languageNameFetcher)) { provider in
                        PokemonSelectionGridScreen(scrollProvider: provider, provider: .init(selectedPokemons: route.selectedPokemons, modelContext: modelContext, teamID: route.teamID))
                    }
                    .environment(teamRouter)
                    .networkedContentView()
                }
                .navigationDestination(for: AddAttackRoute.self) { route in
                    PokemonSelectionMoveListScreen(provider: .init(movesAPI: movesApi, movesURL: route.movesURL, selectedMoves: route.selectedMoves, pokemonID: route.pokemonID, modelContext: modelContext))
                        .environment(teamRouter)
                        .networkedContentView()
                }
                .navigationDestination(for: AddAbilityRoute.self) { route in
                    PokemonAbilitySelectionScreen(provider: .init(pokemonID: route.pokemonID, api: abilityApi, abilities: route.abilities, selected: route.current, modelContext: modelContext))
                        .environment(teamRouter)
                        .networkedContentView()

                }
                .navigationDestination(for: AddNatureRoute.self) { route in
                    PokemonNatureSelectionScreen(provider: .init(api: natureApi, pokemonID: route.pokemonID, stats: route.stats, current: route.current ,modelContext: modelContext))
                        .environment(teamRouter)
                        .networkedContentView()
                }
                .navigationDestination(for: AddItemRoute.self, destination: { route in
                    PaginatedList(provider: .init(api: scrollFetchItemApi, fetchApi: pokemonItemApi, modelContainer: modelContext.container, languageNameFetcher: languageNameFetcher)) { provider in
                        ItemScrolledContent(scrollProvider: provider, provider: .init(modelContainer: modelContext.container, pokemonID: route.pokemonID, current: route.item))
                    }                 
                    .environment(teamRouter)
                    .networkedContentView()
                })
                .navigationDestination(for: PreviewRoute.self) { route in
                    if let pokemon = fetchPokemon(with: route.pokemonID) {
                        PokemonTeamPreviewScreen(pokemon: pokemon)
                            .environment(teamRouter)
                    }
                }
                .navigationDestination(for: MoveRoute.self) { route in
                    MoveScreen(provider: .init(moveData: route.moveData))
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
                .sheet(item: $teamRouter.sharingSheet, content: { route in
                    StartSharingView(provider: .init(teamID: route.teamID, container: modelContext.container, teamRouter: teamRouter))
                        .environment(teamRouter)
                        .presentationDetents([.medium])
                })
                .showMutableIcon()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(value: AddTeamRoute() ) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .environment(teamRouter)
        }
        .onAppear {
            getTeamCount()
        }
    }
    
    private func getTeamCount() {
        teamCount = modelContext.getCount(SDTeam.self)
    }
    
    private func fetchPokemon(with id: Int, and teamID: UUID) -> SDPokemon? {
        modelContext.fetchUniqueSync(with: id, limit: 1, predicate: #Predicate { $0.pokemonID == id})
    }
    
    private func fetchPokemon(with id: PersistentIdentifier) -> SDPokemon? {
        modelContext.fetchUniqueSync(SDPokemon.self, with: id)
    }
    
}

@Observable
public final class TeamRouter {
    var path: NavigationPath
    var sharingSheet: ShareTeamRoute?
    
    init(path: NavigationPath = .init()) {
        self.path = path
    }
    
    func navigate<Route: Hashable>(to route: Route) {
        path.append(route)
    }
    
    func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func backToRoot() {
        path = .init()
    }
    
    func root<Route: Hashable>(as route: Route) {
        self.path = .init([route])
    }
    
    func sharingSheet(_ shareTeamRoute: ShareTeamRoute) {
        self.sharingSheet = shareTeamRoute
    }
    
    func closeSharingSheet() {
        self.sharingSheet = nil
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    let pokemons = JsonReader.readPokemons().map { SDPokemon(pokemonID: $0.id, data: try! JSONEncoder().encode($0)) }
    preview.addExamples(pokemons)
    let team = SDTeam(name: "Plop")
    team.pokemons = pokemons
    preview.addExamples([team])
    return PokemonTeamsScreen(teamRouter: TeamRouter())
        .preferredColorScheme(.dark)
        .inject(container: container)
        .modelContainer(preview.container)
        .environment(TeamRouter())
}
