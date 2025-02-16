//
//  VarietiesListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import SwiftUI
import DI

public struct VarietiesListView<Cell: View>: View {
    
    @Bindable var provider: Provider
    @ViewBuilder var cell: (LocalPokemon) -> Cell
    @State var additionnalCell: (() -> AnyView)?
    @Namespace var varieties
    
    public var body: some View {
        if provider.isGrid {
            ScrollView {
                LazyVGrid(columns: provider.grid,
                          spacing: 4,
                          content: {
                    listContent
                    additionnalCell?()
                        .transaction { view in
                            view.animation = nil
                        }
                })
            }
        } else {
            ScrollView(.horizontal) {
                HStack {
                    listContent
                }
            }
        }
    }
    
    var listContent: some View {
        ForEach(Array(provider.varieties.enumerated()), id: \.0) { (index, pokemon) in
            cell(.init(index: -1, name: pokemon))
                .preference(key: VarietyKey.self, value: index)
        }
    }
    
    func addCell(@ViewBuilder content: @escaping () -> AnyView) -> Self {
        return .init(provider: provider, cell: cell, additionnalCell: content)
    }
    
    
    @Observable @MainActor
    public class Provider {
        let species: SpeciesModel
        let fetchApi: FetchPokemonApi
        let speciesApi: PokemonSpeciesApi
        let grid: [GridItem]
        var varieties: [String]
        var isGrid: Bool
        
        init(species: SpeciesModel, fetchApi: FetchPokemonApi, speciesApi: PokemonSpeciesApi, isGrid: Bool) {
            self.grid = .init(repeating: .init(.fixed(120)), count: 3)
            self.isGrid = isGrid
            self.species = species
            self.fetchApi = fetchApi
            self.speciesApi = speciesApi
            self.varieties = []
            Task {
                await fetch()
            }
        }
        
        func fetch() async {
            let result = await speciesApi.fetch(query: .init(speciesNumber: species.id))
            switch result {
            case .success(let success):
                varieties = success.varieties.map(\.pokemon.name)
            case .failure(let failure):
                print(#file, #function, "\n", failure)
            }
        }
    }
}

struct VarietyKey: PreferenceKey {
    
    nonisolated(unsafe) static var defaultValue: Int = 0
    
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value += nextValue()
    }
    
    typealias Value = Int
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    
    return VarietiesListView(provider: .init(species: .init(id: "3"), fetchApi: .init(), speciesApi: .init(), isGrid: true)) { pokemon in
        EvolutionListViewCell(provider: .init(api: .init(), pokemon: pokemon))
    }
    .addCell(content: {
        AnyView(
            Rectangle()
                .frame(width: 120, height: 120, alignment: .center)
                .foregroundColor(.red)
                .overlay(content: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                })
        )
    })
    .inject(container: container)
    .environment(PokemonDetailsProvider(api: .init(), speciesApi: .init(), evolutionChainApi: .init(), abilitiesApi: .init(), localPokemon: .init(index: 3, name: "venusaur"), player: .init()))
    .preferredColorScheme(.dark)
    
}
