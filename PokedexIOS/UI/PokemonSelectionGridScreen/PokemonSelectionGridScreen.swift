//
//  PokemonChoiceGridView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import SwiftData
import Tools

public struct PokemonSelectionGridScreen: View {
    
    typealias ScrollProvider = PaginatedList<Self, ScrollFetchPokemonApi, FetchPokemonApi>.Provider
    
    @Environment(\.isIphone) var isIphone
    @Environment(\.isLandscape) var isLandscape
    @Environment(\.dismissSearch) var dismisSearch
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var container
    @DIContainer var speciesApi: PokemonSpeciesApi
    @Bindable var scrollProvider: ScrollProvider
    @State private var showSelection: Bool = false
    @State var provider: Provider
    @State var showVarietiesFor: LocalPokemon?
    @Namespace var listSpace

    
    public var body: some View {
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
                VStack(spacing: 0) {
                    Spacer()
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
                    } buildTeamButton: {
                        if isSearching {
                            HStack {
                                buildTeamButton
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
            }
        })
        .animation(.easeInOut, body: { view in
            view
                .blur(radius: provider.isShowingSheet ? 1 : 0)
                .opacity(provider.isShowingSheet ? 0.5 : 1.0)
        })
        .sheet(item: $provider.teamNameItemIphone) { _ in
            iphoneTeamCreationSheet
        }
        .overlay(alignment: .bottom, content: {
            ipadTeamChreationSheet
        })
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
            hamdlePlatformSheet()
        } label: {
            Text(provider.isNewTeam ? "Build Team !" : "Update Team !")
        }
    }
    
    var buildTeamButton : some View {
        Button {
            dismisSearch()
            hamdlePlatformSheet()
        } label: {
           Image(systemName: "hammer.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
    }
    
    @ViewBuilder
    var iphoneTeamCreationSheet: some View {
        if isIphone {
            TeamNameSheet(provider: provider) {
                dismiss.callAsFunction()
            }
            .presentationDetents(isLandscape ? [.fraction(0.3)] :[.height(100)])
            .presentationDragIndicator(.hidden)
            .presentationContentInteraction(.scrolls)
        }
    }
    
    @ViewBuilder
    var ipadTeamChreationSheet: some View {
        if !isIphone && provider.teamNameItemIpad != nil {
            VStack {
                Color.black.opacity(0.001)
                    .onTapGesture {
                        withAnimation {
                            provider.teamNameItemIpad = nil
                        }
                    }
                TeamNameSheet(provider: provider) {
                    dismiss.callAsFunction()
                }
                .frame(height: 200)
                .background(RoundedRectangle(cornerRadius: 12).fill(.ultraThickMaterial))
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func hamdlePlatformSheet() {
        withAnimation {
            if isIphone {
                provider.teamNameItemIphone = .init()
            } else {
                provider.teamNameItemIpad = .init()
            }
        }
    }
    
    @Observable
   public class Provider {
        
        var selectedPokemons: [Pokemon]
        private var modelContext: ModelContext
        private var teamID: PersistentIdentifier?
        var eventBound: GridCellPOkemonSelectionEventBound
        
        var teamName: String
        var teamNameItemIphone: TeamNameSheet.TeamNameItem?
        var teamNameItemIpad: TeamNameSheet.TeamNameItem?
        
        var isShowingSheet: Bool {
            teamNameItemIpad != nil || teamNameItemIphone != nil
        }

        let grid: [GridItem]
        
        var isNewTeam: Bool {
            teamID == nil
        }
        
        init(selectedPokemons: [Pokemon], modelContext: ModelContext, teamID: PersistentIdentifier?, eventBound: GridCellPOkemonSelectionEventBound = .init()) {
            self.grid = .init(repeating: .init(.adaptive(minimum: 120)), count: 3)
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
            teamNameItemIphone = nil
            teamNameItemIpad = nil
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
            teamNameItemIphone = nil
            teamNameItemIpad = nil
        }
    }
}

public struct TeamNameSheet: View {
    
    @Bindable var provider: PokemonSelectionGridScreen.Provider
    var onFinish: () -> Void
    public var body: some View {
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
                    onFinish()
                }, label: {
                   Image(systemName: "square.and.arrow.down")
                })
                .disabled(provider.teamName.count < 3)
            }
        }
        .bold()
        .padding(.horizontal)
    }
    
    public struct TeamNameItem: Identifiable, Hashable {
        public let id: UUID = .init()
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
