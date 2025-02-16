//
//  ItemScrollList.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import SwiftUI
import Combine
import SwiftData
import Resources
import Tools
import DI
import Dtos

public struct ItemScrolledContent: View {
    typealias ScrollProvider = PaginatedList<Self, ScrollFetchItemApi, PokemonItemApi>.Provider
    @Bindable var scrollProvider: ScrollProvider
    @State var provider: Provider
    @Environment(\.isIphone) var isIphone
    @Environment(\.dismiss) var dismiss
    @Environment(\.isSearching) var isSearching
    
    public var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(provider.selectionActive ? "Cancel" : "Select") {
                            provider.handleSelection()
                        }
                        Button("Save") {
                            provider.save()
                            dismiss.callAsFunction()
                        }
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    if isIphone && isSearching && provider.selectionActive && provider.selected != nil {
                        Button("Save") {
                            provider.save()
                            dismiss.callAsFunction()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(.ultraThickMaterial))
                        .padding(.bottom, 40)
                    }
                }
            }
    }
    
    private var content: some View {
        List {
            listContent
                .listRowBackground(EmptyView())
        }
    }
    
    private func forEach(providers: [Provider.CellProvider]) -> some View {
        ForEach(Array(providers.enumerated()), id:\.offset) { offset, element in
            ItemCell(provider: element, onSelect: { provider.handleSelection($0) }, onDeselect: { provider.handleDeselection($0) })
                .onAppear {
                    scrollProvider.update(from: offset)
                }
                .id(element.itemName)
        }
        .loadable(isLoading: providers.isEmpty)
    }
    
    private func searchedList(_ searched: [Provider.CellProvider]) -> some View {
        ForEach(Array(searched.enumerated()), id:\.offset) { offset, item in
            ItemCell(provider: item, onSelect: { provider.handleSelection($0) }, onDeselect: { provider.handleDeselection($0) })
                .onAppear {
                    scrollProvider.update(from: offset)
                }
                .id(item.item?.name)
        }
        .loadable(isLoading: searched.isEmpty)
    }
    
    @ViewBuilder
    private  var listContent: some View {
        if let fetched = scrollProvider.searched {
            searchedList(fetched.map { provider.toProvider(searched: $0, fetchApi: scrollProvider.fetchApi)  })
                .onAppear {
                    if !provider.selectionActive {
                        provider.handleSelection()
                    }
                }
        } else {
            forEach(providers: scrollProvider.config.list.map { provider.toProvider(element: $0.element, fetchApi: scrollProvider.fetchApi) })
        }
    }
    
    @Observable @MainActor
    public final class Provider {
        
        typealias CellProvider = ItemCell.Provider
        
        private let modelContainer: ModelContainer
        private let pokemonID: PersistentIdentifier
        @ObservationIgnored
        private let current: Item?
        
        var selected: SelectedModel?
        var selectionActive: Bool
        @ObservationIgnored
        var providers: [CellProvider]
        
        init(
            modelContainer: ModelContainer,
            pokemonID: PersistentIdentifier,
            current: Item?
        ) {
            self.modelContainer = modelContainer
            self.pokemonID = pokemonID
            self.current = current
            self.selectionActive = current != nil
            self.providers = []
        }
        
        func toProvider(searched: ScrollProvider.SearchedElement<Item>, fetchApi: PokemonItemApi) -> CellProvider {
            let p: CellProvider = .init(api: fetchApi, item: searched.element, languageName: searched.language)
            p.isSelectable = selectionActive
            self.providers.append(p)
            return p
        }
        
        func toProvider(element: NamedAPIResource, fetchApi: PokemonItemApi) -> CellProvider {
            let p = CellProvider(api: fetchApi, scrolledFetchedItem: element)
            p.isSelectable = selectionActive
            self.providers.append(p)
            return p
        }
        
        func handleSelection() {
            selectionActive.toggle()
            for provider in providers {
                provider.isSelectable = selectionActive
            }
            Vibrator.selection()
        }
        
        func handleSelection(_ item: Item?) {
            guard let item else { return }
            for provider in providers {
                provider.isSelected = item.name == (provider.item?.name ?? "")
            }
            selected = .init(item: item)
            Vibrator.selection()
        }
        
        func handleDeselection(_ item: Item?) {
            guard let item else { return }
            if let p = providers.first(where: { $0.item == item }) {
                p.isSelected = false
            }
            selected = nil
            Vibrator.selection()
        }
        
        @MainActor
        func save() {
            guard let current = selected?.item else {
                return
            }
            let context = modelContainer.mainContext
            let pokemon = context.fetchUniqueSync(SDPokemon.self, with: pokemonID)
            let item = SDItem(itemID: current.id, data: try? JSONEncoder().encode(current))
            context.insert(item)
            pokemon?.item = item
            try? context.save()
            Vibrator.notify(of: .success)
        }
    }
    
    public struct ItemDataModel: Hashable {
        var name: String
    }
    
    public struct SelectedModel: Hashable {
        let item: Item?
    }
    
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    let pokemon = JsonReader.readPokemons().randomElement()!
    let sdPokemon = SDPokemon(pokemonID: pokemon.order, data: try? JSONEncoder().encode(pokemon))
    preview.addExamples([sdPokemon])
    return NavigationStack {
        PaginatedList(
            provider: .init(
                api: ScrollFetchItemApi(),
                fetchApi: PokemonItemApi(),
                modelContainer: preview.container,
                languageNameFetcher: .init(
                    container: preview.container
                )
            )) { provider in
                ItemScrolledContent(
                    scrollProvider: provider,
                    provider: .init(
                        modelContainer: preview.container,
                        pokemonID: sdPokemon.persistentModelID,
                        current: nil
                    )
                )
            }
    }
    .modelContainer(preview.container)
    .inject(container: container)
    .preferredColorScheme(.dark)
}
