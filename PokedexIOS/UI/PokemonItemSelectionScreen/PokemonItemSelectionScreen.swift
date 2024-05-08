//
//  PokemonItemSelectionScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation
import SwiftUI
import SwiftData

public struct PokemonItemSelectionScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @DIContainer var itemApi: PokemonItemApi
    @State var provider: Provider
    
    public var body: some View {
        ScrollViewReader { reader  in
            if let fetched = provider.searched {
                VStack {
                    CellContent(fetched, index: 0)
                    Spacer()
                }
            } else {
                List(provider.displayedProviders, id: \.1.id) { index, cellProvider in
                    CellContent(cellProvider, index: index)
                }
            }
        }
        .searchable(text: $provider.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: provider.searchText, { oldValue, newValue in
            provider.onSearch(newValue: newValue)
        })
        .autocorrectionDisabled(true)
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
        }
        .loadable(isLoading: provider.paginatedProviders.isEmpty)
    }
    
    func CellContent(_ cellProvider: Provider.CellProvider, index: Int) -> some View {
        ItemCell(provider: cellProvider, onSelect: { self.provider.handleSelection($0) }, onDeselect: { self.provider.handleDeselection($0) })
            .id(cellProvider.item?.id)
            .onAppear {
                provider.handleScrolling(from: index)
            }
            .listRowSeparator(.hidden)
    }

    @Observable
   public class Provider {
        
        typealias CellProvider = ItemCell.Provider
        
        let categoryApi: PokemonCategoryItemApi
        let pokemonItemApi: PokemonItemApi
        let generalApi: GeneralApi<ItemCategories>
        let modelContainer: ModelContainer
        let pokemonID: PersistentIdentifier
        
        @ObservationIgnored
        private let current: Item?

        var selected: SelectedModel?
        
        var selectionActive: Bool
        
        @ObservationIgnored
        var providers: [CellProvider]
        var paginatedProviders: [CellProvider]
        var displayedProviders: [(Int, CellProvider)]
        
        @ObservationIgnored
        var categories: [ItemCategoryType]
        private var pItems: [ItemDataModel]
        var searchText: String
        var searchTask: Task<Void, Never>?
        var searched: CellProvider?
        
        let languageNameFetcher: LanguageNameFetcher
        
        init(categoryApi: PokemonCategoryItemApi,
             generalApi: GeneralApi<ItemCategories>,
             pokemonItemApi: PokemonItemApi,
             modelContainer: ModelContainer,
             pokemonID: PersistentIdentifier,
             current: Item?
        ) {
            self.categoryApi = categoryApi
            self.generalApi = generalApi
            self.pokemonItemApi = pokemonItemApi
            self.pItems = []
            self.categories = []
            self.searchText = current?.name ?? ""
            self.modelContainer = modelContainer
            self.pokemonID = pokemonID
            self.current = current
            self.selectionActive = current != nil
            self.providers = []
            self.paginatedProviders = []
            self.displayedProviders = []
            self.languageNameFetcher = .init(container: modelContainer)
            Task {
                await fetch()
                onSearch(newValue: current?.name ?? "")
            }
        }
        
        private func fetch() async {
            let url = URL(string: "https://pokeapi.co/api/v2/item-category/")!
            let result = await generalApi.fetch(query: .init(url: url))
            switch result {
            case .success(let success):
                let categories = success.results.map(\.name)
                await fetchBy(categories: categories)
            case .failure(let failure):
                print(#file, "\n", #function, failure)

            }
        }
        
        private func fetchBy(categories: [ItemCategoryType]) async {
            let fetchables = filterCategories(categories: categories)
            self.categories = fetchables
            let categories = await withTaskGroup(of: PokemonCategoryItemApi.Requested?.self) { group in
                fetchables.forEach { type in
                    group.addTask {
                        let result = await self.categoryApi.fetch(query: .init(categoryID: type.getName()))
                        switch result {
                        case .success(let success):
                            return success
                        case .failure(let failure):
                            print(#file, "\n", #function, failure, type)
                            return nil
                        }
                    }
                }
                var categories = [PokemonCategoryItemApi.Requested]()
                for await category in group {
                    if let category {
                        categories.append(category)
                    }
                }
                return categories
            }
            
            Task {
                let items = categories.map(\.items)
                let result = items.reduce(into: [ItemDataModel]()) { partialResult, resources in
                    let r = resources.map { ItemDataModel(name: $0.name) }
                    let result = Set(partialResult + r )
                    partialResult = Array(result)
                }
                
                let sortedResult = result.sorted(by: { $0.name < $1.name })
                let providers = sortedResult.map { CellProvider(api: pokemonItemApi, scrolledFetchedItem: .init(name: $0.name, url: .temporaryDirectory), isSelectable: selectionActive) {[weak self] item, provider in
                    if item.name == self?.current?.name {
                        provider.isSelected = true
                    }
                }}
                await MainActor.run {
                    withAnimation {
                        self.providers = providers
                        paginatedProviders = Array(providers[0..<min(20, providers.count)])
                    }
                    if let current {
                        selected = .init(item: current)
                    }
                }
            }
        }
        
        private func filterCategories(categories: [ItemCategoryType]) -> [ItemCategoryType] {
            let types =  categories.filter {
                let name = $0.getName()
                return name == ItemCategoryType.heldItems.getName() ||
                name == ItemCategoryType.badHeldItems.getName() ||
                name == ItemCategoryType.zCrystals.getName() ||
                name == ItemCategoryType.dynamaxCrystals.getName() ||
                name == ItemCategoryType.teraShard.getName() ||
                name == ItemCategoryType.megaStones.getName() ||
                name == ItemCategoryType.pickyHealing.getName() ||
                name == ItemCategoryType.medicine.getName() ||
                name == ItemCategoryType.inAPinch.getName() ||
                name == ItemCategoryType.jewels.getName() ||
                name == ItemCategoryType.loot.getName() ||
                name == ItemCategoryType.effortDrop.getName() ||
                name == ItemCategoryType.other.getName() ||
                name == ItemCategoryType.typeProtection.getName() ||
                name == ItemCategoryType.typeEnhancement.getName() ||
                name == ItemCategoryType.choice.getName() ||
                name == ItemCategoryType.plates.getName() ||
                name == ItemCategoryType.speciesSpecific.getName() ||
                name == ItemCategoryType.memories.getName()
            }
            return types
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
                provider.isSelected = item.name == provider.item?.name
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
        
        func handleScrolling(from index: Int) {
            if index == paginatedProviders.count-1 {
                let offset = min(providers.count, index+20)
                let newContent = providers[index+1..<offset]
                paginatedProviders.append(contentsOf: newContent)
            }
        }
        
        func onSearch(newValue: String) {
            cleanSearchTask()
            searchTask = Task {
                do {
                    try await Task.sleep(for: .seconds(0.3))
                    await fetch(for: newValue.lowercased())
                } catch {
                    //print(#function, error)
                }
            }
        }
        
        private func fetch(for name: String) async {
            guard !name.isEmpty else {
                cleanSearchTask()
                await MainActor.run {
                    displayedProviders = Array(paginatedProviders.enumerated())
                }
                return
            }
            let filtered = providers.filter { $0.scrolledFetchedItem?.name.contains(name) ?? false }
            if !filtered.isEmpty {
                await MainActor.run {
                    handleSelection(current)
                    searched = nil
                    displayedProviders = Array(filtered.enumerated())
                }
                return
            }
        }
        
        private func cleanSearchTask() {
            searched = nil
            searchTask?.cancel()
            searchTask = nil
        }
        
        func save() {
            guard let current = selected?.item else {
                return
            }
            Task {
                let backgroundHandler = BackgroundDataHander(with: modelContainer)
                let pokemon = backgroundHandler.fetch(type: SDPokemon.self, fetchLimit: 1, predicate: #Predicate { $0.persistentModelID == pokemonID }).first
                let item = SDItem(itemID: current.id, data: try? JSONEncoder().encode(current))
                backgroundHandler.insert(item)
                pokemon?.item = item
                backgroundHandler.save()
                Vibrator.notify(of: .success)

            }
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
    @Environment(\.diContainer) var container
    
    let preview =  Preview.allPreview
    let pokemon = JsonReader.readPokemons().randomElement()!
    let sdPokemon = SDPokemon(pokemonID: pokemon.order, data: try? JSONEncoder().encode(pokemon))
    preview.addExamples([sdPokemon])
    
    return NavigationStack {
        PokemonItemSelectionScreen(provider: .init(categoryApi: .init(), generalApi: .init(), pokemonItemApi: .init(), modelContainer: preview.container, pokemonID: sdPokemon.persistentModelID, current: nil))
            .inject(container: container)
    }
    .modelContainer(preview.container)
    .preferredColorScheme(.dark)
}


