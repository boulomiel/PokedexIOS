//
//  PokemonChoiceGridCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import Combine
import Tools
import DI
import Dtos

public struct PokemonSelectionGridCell: View {
    
    @Environment(TeamRouter.self) var teamRouter
    @State var selectedPokemon: [Pokemon]
    @State var showSelection: Bool
    @State var provider: Provider
    
    @State private var showVarietiesForCell: LocalPokemon?
    @Namespace var listSpace
    
    public var body: some View {
        VStack {
            PokeballImageAsync(url: provider.sprite, width: 100, height: 100)
            ShrinkText(text: provider.pokemonName.capitalized, alignment: .center, font: .body.bold(), width: nil)
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
        .background {
            ZStack {
                Spacer()
            }
            .frame(width: 80, height: 80, alignment: .leading)
            .pokemonTypeBackgroundCircle(types: provider.types)
            .clipShape(Circle())
        }
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
    
    public struct SelectAnim {
        var scale: Double = 1.0
    }
    
    @Observable @MainActor
    public class Provider {
        
        let api: FetchPokemonApi
        let speciesApi: PokemonSpeciesApi
        var pokemon: LocalPokemon
        let eventBound: GridCellPokemonSelectionEventBound
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
        var types: [PokemonType.PT] {
            fetchedPokemon?.types.pt ?? []
        }
        var isSelected: Bool
        var showVarietyButton: Bool
        
        init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, pokemon: LocalPokemon, eventBound: GridCellPokemonSelectionEventBound) {
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
        
        init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, fetchedPokemon: Pokemon, languageName: LanguageName, eventBound: GridCellPokemonSelectionEventBound) {
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
                withAnimation(.smooth) {
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
                self.showVarietyButton = result.varieties.count > 1
            case .failure(let error):
                print(#file, #function, error)
            }
        }
    }
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    
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
