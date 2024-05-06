//
//  PokemonChoiceGridView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import SwiftData

struct PokemonSelectionGridScreen: View {
    
    typealias ScrollProvider = PaginatedList<Self, ScrollFetchPokemonApi, FetchPokemonApi>.Provider
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var container
    @DIContainer var speciesApi: PokemonSpeciesApi
    @Bindable var scrollProvider: ScrollProvider
    @State private var showSelection: Bool = false
    @State var provider: Provider
    @State var showVarietiesFor: LocalPokemon?
    @Namespace var listSpace

    
    var body: some View {
        ScrollViewReader(content: { reader in
            ZStack {
                if let showVarietiesFor {
                    SelectVarietieView(showVarietiesFor: showVarietiesFor)
                } else {
                    listContent
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        closeVarietyButton
                        selectCancelButton
                        if provider.selectedPokemons.count == 6 {
                            createTeamButton
                        }
                    }
                }
            }
            .overlay {
                PokeBallBeltView(selectedPokemons: provider.selectedPokemons) { show  in
                    guard let pokemon = show else { return }
                    if scrollProvider.config.list.contains(where: { $0.element.name == pokemon.name }) {
                        withAnimation {
                            reader.scrollTo(pokemon.name)
                        }
                        scrollProvider.config.searchText = ""
                    } else {
                        scrollProvider.config.searchText = pokemon.name
                    }
                } onRemovePokemon: { remove in
                    provider.selectedPokemons.removeAll(where: { $0.id == remove?.id })
                }
                .padding(.bottom, 10)
            }
        })
        .animation(.easeInOut, body: { view in
            view
                .blur(radius: provider.teamNameItem == nil ? 0 : 1)
                .opacity(provider.teamNameItem == nil ? 1 : 0.5)
        })
        .sheet(item: $provider.teamNameItem) { _ in
            TeamNameSheet(provider: provider)
                .presentationDetents([.height(100)])
                .presentationDragIndicator(.hidden)
                .presentationContentInteraction(.scrolls)
                .onDisappear(perform: {
                    dismiss.callAsFunction()
                })
        }
        .preferredColorScheme(.dark)
        .onReceive(provider.eventBound.event, perform: { event in
            switch event {
            case .showSelection(let isSelected):
                showSelection = isSelected
            case .selectedPokemon(pokemons: let pokemons):
                provider.selectedPokemons = pokemons
            case .showVarietiesForCell(local: let local):
                showVarietiesFor = local
            }
        })
        .onAppear(perform: {
            showSelection = !provider.selectedPokemons.isEmpty
        })
    }
    
    var baseList: some View {
        LazyVGrid(columns: provider.grid,
                  content: {
            ForEach(scrollProvider.config.list, id:\.0) { (index, pokemon) in
                GridCell(index: index, name: pokemon.name)
                    .onAppear {
                        scrollProvider.update(from: index)
                    }
            }
        })
    }
    
    func searchedList(_ pokemons: [ScrollProvider.SearchedElement<Pokemon>]) -> some View {
        LazyVGrid(columns: provider.grid,
                  content: {
            ForEach(Array(pokemons.enumerated()), id:\.0) { (index, pokemon) in
                GridCellLanguaged(searched: pokemon)
                    .onAppear {
                        scrollProvider.update(from: index)
                    }
            }
        })
    }
    
    var listContent: some View {
        ScrollView {
            if let fetched = scrollProvider.searched {
                searchedList(fetched)
            } else {
                baseList
            }
        }
    }
    
    @ViewBuilder
    func GridCell(index: Int, name: String) -> some View {
        PokemonSelectionGridCell(
            selectedPokemon: provider.selectedPokemons,
            showSelection: showSelection,
            provider: .init(
                api: scrollProvider.fetchApi, speciesApi: speciesApi,
                pokemon: .init(
                    index: index,
                    name: name
                ), eventBound: provider.eventBound
            )
        )
        .id(name)
    }
    
    @ViewBuilder
    func GridCellLanguaged(searched: ScrollProvider.SearchedElement<Pokemon>) -> some View {
        PokemonSelectionGridCell(
            selectedPokemon: provider.selectedPokemons,
            showSelection: showSelection,
            provider: .init(api: scrollProvider.fetchApi,
                            speciesApi: speciesApi,
                            fetchedPokemon: searched.element,
                            languageName: searched.language,
                            eventBound: provider.eventBound)
        )
        .id(searched.language.english)
    }
        
    func SelectVarietieView(showVarietiesFor: LocalPokemon) -> some View {
        VStack {
            GridCell(index: showVarietiesFor.index, name: showVarietiesFor.name)
                .padding()
            VarietiesListView(provider: .init(species: SpeciesModel(id: showVarietiesFor.name), fetchApi: scrollProvider.fetchApi, speciesApi: speciesApi, isGrid: true)) { localPokemon in
                if localPokemon.name != showVarietiesFor.name {
                    GridCell(index: localPokemon.index, name: localPokemon.name)
                }
            }
            .addCell(content: {
                AnyView(
                    Button(action: {
                        withAnimation {
                            provider.eventBound.event.send(.showVarietiesForCell(local: nil))
                        }
                    }, label: {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity, minHeight: 120)
                            .overlay(content: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                            })
                    })
                )
            })
            Spacer()
        }
    }
    
    @ViewBuilder
    var closeVarietyButton: some View {
        if showVarietiesFor != nil {
            Button("Back") {
                withAnimation {
                    provider.eventBound.event.send(.showVarietiesForCell(local: nil))
                }
            }
        }
    }
    
    var selectCancelButton: some View {
        Button(showSelection ? "Drop changes" : "Select") {
           let updated = !showSelection
            provider.eventBound.event.send(.showSelection(updated))
            provider.cleanSelection()
        }
    }
    
    var createTeamButton : some View {
        Button {
            provider.teamNameItem = .init()
        } label: {
            Text(provider.isNewTeam ? "Build Team !" : "Update Team !")
        }
    }
    
    @Observable
    class Provider {
        
        var selectedPokemons: [Pokemon]
        private var modelContext: ModelContext
        private var teamID: PersistentIdentifier?
        var eventBound: GridCellPOkemonSelectionEventBound
        
        var teamName: String
        var teamNameItem: TeamNameSheet.TeamNameItem?
        let grid: [GridItem]
        
        var isNewTeam: Bool {
            teamID == nil
        }
        
        init(selectedPokemons: [Pokemon], modelContext: ModelContext, teamID: PersistentIdentifier?, eventBound: GridCellPOkemonSelectionEventBound = .init()) {
            self.grid = .init(repeating: .init(.fixed(120)), count: 3)
            self.selectedPokemons = selectedPokemons
            self.teamID = teamID
            self.teamName = ""
            self.modelContext = modelContext
            self.eventBound = eventBound
        }
        
        func cleanSelection() {
            eventBound.event.send(.selectedPokemon(pokemons: []))
        }
        
        func handleTeamChanges() {
            if isNewTeam {
                saveTeam()
            } else {
                updateTeam()
            }
        }
        
        private func saveTeam() {
            let datas = selectedPokemons.compactMap {
                ($0.id ,try? JSONEncoder().encode($0))
            }
            let team = SDTeam(name: teamName)
            let pokemons = datas.map { SDPokemon(pokemonID: $0.0, data: $0.1) }
            pokemons.forEach { pokemon in
                modelContext.insert(pokemon)
            }
            team.pokemons = pokemons
            modelContext.insert(team)
            try? modelContext.save()
            teamNameItem = nil
            Vibrator.notify(of: .success)
        }
        
        private func updateTeam() {
            guard let teamID else { return }
            let datas = selectedPokemons.compactMap {
                ($0.id ,try? JSONEncoder().encode($0))
            }
            let pokemons = datas.map { SDPokemon(pokemonID: $0.0, data: $0.1) }
            pokemons.forEach { pokemon in
                modelContext.insert(pokemon)
            }
            if let team = modelContext.fetchUniqueSync(SDTeam.self,with: teamID) {
                team.name = teamName
                team.pokemons = pokemons
                try? modelContext.save()
                Vibrator.notify(of: .success)
            } else {
                saveTeam()
            }
            teamNameItem = nil
        }
    }
}

struct TeamNameSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var provider: PokemonSelectionGridScreen.Provider
    
    var body: some View {
        LabeledContent("Team name") {
            HStack {
                TextField("", text: $provider.teamName)
                    .lineLimit(1)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.words)
                    .background(Color.white)
                    .textFieldStyle(.automatic)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Button(action: {
                    provider.handleTeamChanges()
                }, label: {
                   Image(systemName: "square.and.arrow.down")
                })
                .disabled(provider.teamName.count < 3)
            }
        }
        .bold()
        .padding(.horizontal)
    }
    
    struct TeamNameItem: Identifiable, Hashable {
        let id: UUID = .init()
    }
}


#Preview {
    
    let preview = Preview(SDTeam.self, SDPokemon.self, SDItem.self, SDMove.self)
    @Environment(\.diContainer) var container
    
    return NavigationStack(root: {
        PokemonSelectionGridScreen(scrollProvider: .init(api: .init(), fetchApi: .init(), modelContainer: preview.container), provider: .init(selectedPokemons: [], modelContext: preview.container.mainContext, teamID: nil))
    })
    .preferredColorScheme(.dark)
    .modelContainer(preview.container)
    .environment(TeamRouter())
    .inject(container: container)
}
