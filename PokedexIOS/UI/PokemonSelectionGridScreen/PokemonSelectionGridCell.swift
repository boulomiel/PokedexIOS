//
//  PokemonChoiceGridCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import Combine

class GridCellPOkemonSelectionEventBound {
    enum EventBound {
        case showSelection(Bool)
        case selectedPokemon(pokemons: [Pokemon])
        case showVarietiesForCell(local: LocalPokemon?)
    }
    
    let event: PassthroughSubject<EventBound, Never>
    
    init(event: PassthroughSubject<EventBound, Never> = .init()) {
        self.event = event
    }
}

struct PokemonSelectionGridCell: View {
    
    @Environment(TeamRouter.self) var teamRouter
    @State var selectedPokemon: [Pokemon]
    @State var showSelection: Bool
    @State var provider: Provider

    @State private var showVarietiesForCell: LocalPokemon?
    @Namespace var listSpace
    
    var body: some View {
        VStack {
            ScaleAsyncImage(url: provider.sprite, width: 100, height: 100)
            Text(provider.pokemonName.capitalized)
                .frame(maxWidth: .infinity)
                .minimumScaleFactor(0.1)
                .bold()
            
        }
        .keyframeAnimator(initialValue: SelectAnim(), trigger: provider.isSelected) { view, value in
            view
                .scaleEffect(value.scale)
        } keyframes: { value in
            KeyframeTrack(\.scale) {
                CubicKeyframe(1.2, duration: 0.2)
                SpringKeyframe(0.8, duration: 0.1)
            }
        }
        .overlay(alignment: .topTrailing, content: {
            selectionIndicatorImage
        })
        .padding(4)
        .background(shape.fill(Color.gray.opacity(0.3)))
        .onTapGesture {
            onCellTapAction()
        }
        .contextMenu(menuItems: {
            if provider.isDefaultForm {
                addToTeamButton
                varietyButton
            }
            pokemonDetailLink
        })
        .onReceive(provider.eventBound.event, perform: { event in
            switch event {
            case .showSelection(let isSelected):
                self.showSelection = isSelected
                if !isSelected {
                    selectedPokemon = []
                    provider.eventBound.event.send(.selectedPokemon(pokemons: []))
                    provider.isSelected = false
                }
            case .selectedPokemon(pokemons: let pokemons):
                provider.isSelected = pokemons.contains(where: { $0.name == provider.pokemon.name })
                selectedPokemon = pokemons
            case .showVarietiesForCell(local: let local):
                showVarietiesForCell = local
            }
        })
        .onAppear(perform: {
            if selectedPokemon.contains(where: {$0.name == provider.pokemon.name}) {
                provider.isSelected = true
            }
        })
        .matchedGeometryEffect(id: provider.pokemon, in: listSpace)
    }
    
    var shape: some Shape {
        RoundedRectangle(cornerRadius: 8)
    }
    
    @ViewBuilder
    var selectionIndicatorImage: some View {
        if provider.isDefaultForm {
            Image(systemName: provider.isSelected ? "checkmark.circle" : "circle")
                .foregroundStyle(provider.isSelected ? Color.white : Color.gray.opacity(0.3))
                .keyframeAnimator(initialValue: SelectAnim(), trigger: provider.isSelected) { view, value in
                    view
                        .scaleEffect(value.scale)
                } keyframes: { value in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.2, duration: 0.2)
                        SpringKeyframe(0.8, duration: 0.1)
                    }
                }
        }
    }
    
    var pokemonDetailLink: some View {
        NavigationLink(value: provider.pokemon) {
            Label("Pokemon details", systemImage: "info")
        }
    }
    
    @ViewBuilder
    var varietyButton: some View {
        if provider.showVarietyButton && showVarietiesForCell == nil  {
            Button {
                provider.eventBound.event.send(.showVarietiesForCell(local: provider.pokemon))
            } label: {
                Label("Show varieties", systemImage: "plus.square.on.square")
            }
        }
    }
    
    @ViewBuilder
    var addToTeamButton: some View {
        if !provider.isSelected && !showSelection {
            Button(action: {
                withAnimation {
                    provider.eventBound.event.send(.showSelection(true))
                    if let selected = provider.fetchedPokemon {
                        provider.eventBound.event.send(.selectedPokemon(pokemons: selectedPokemon + [selected]))
                    }
                }
            }, label: {
                Label("Add to team", systemImage: "plus")
            })
        }
    }
    
    func onCellTapAction() {
        if showSelection && provider.isDefaultForm {
            withAnimation {
                if let selected = provider.fetchedPokemon {
                    var selection = selectedPokemon
                    if !selection.contains(where: { $0.id == selected.id}) {
                        guard selection.count < 6 else { return }
                        selection.append(selected)
                    } else {
                        selection.removeAll(where: { $0.id == selected.id })
                    }
                    provider.eventBound.event.send(.selectedPokemon(pokemons: selection))
                }
            }
            Vibrator.selection()
        }
    }
    
    struct SelectAnim {
        var scale: Double = 1.0
    }
    
    @Observable
    class Provider {
        
        let api: FetchPokemonApi
        let speciesApi: PokemonSpeciesApi
        var pokemon: LocalPokemon
        let eventBound: GridCellPOkemonSelectionEventBound
        var fetchedPokemon: Pokemon?
        let languageName: LanguageName
        
        var pokemonName: String {
            if case let .en(englishName) = languageName {
                return englishName
            } else {
                return languageName.foreign
            }
        }
        
        var sprite: URL? {
            fetchedPokemon?.sprites?.frontDefault
        }
        var isDefaultForm: Bool {
            fetchedPokemon?.isDefault ?? false
        }
        var isSelected: Bool
        var showVarietyButton: Bool
                
        init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, pokemon: LocalPokemon, eventBound: GridCellPOkemonSelectionEventBound) {
            self.api = api
            self.pokemon = pokemon
            self.isSelected = false
            self.showVarietyButton = false
            self.speciesApi = speciesApi
            self.eventBound = eventBound
            self.languageName = .en(englishName: pokemon.name)
            Task {
                await fetch()
            }
        }
        
        init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, fetchedPokemon: Pokemon, languageName: LanguageName, eventBound: GridCellPOkemonSelectionEventBound) {
            self.api = api
            self.isSelected = false
            self.showVarietyButton = false
            self.speciesApi = speciesApi
            self.eventBound = eventBound
            self.fetchedPokemon = fetchedPokemon
            self.languageName = languageName
            self.pokemon = .init(index: fetchedPokemon.order, name: fetchedPokemon.name)
            Task {
                await getSpecies(for: fetchedPokemon)
            }
        }
        
        private func fetch() async {
            let result = await api.fetch(query: .init(pokemonID: pokemon.name))
            switch result {
            case .success(let result):
                await getSpecies(for: result)
                await MainActor.run {
                    fetchedPokemon = result
                }
            case .failure(let error):
                print(#file, #function, error)
            }
        }
        
        private func getSpecies(for result: Pokemon) async {
            let result = await speciesApi.fetch(query: .init(speciesNumber: result.species.name))
            switch result {
            case .success(let result):
                await MainActor.run {
                    self.showVarietyButton = result.varieties.count > 1
                }
            case .failure(let error):
                print(#file, #function, error)
            }
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    
    return PokemonSelectionGridCell(
        selectedPokemon:
            []
        ,
        showSelection: false, 
        provider: .init(
            api: .init(),
            speciesApi: .init(),
            pokemon: .init(
                index: 25,
                name: "pikachu"
            ),
            eventBound: .init()
        )
    )
    .inject(container: container)
    .environment(TeamRouter())
    .preferredColorScheme(.dark)
}
