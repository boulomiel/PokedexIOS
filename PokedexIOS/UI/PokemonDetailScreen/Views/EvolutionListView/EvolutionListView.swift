//
//  EvolutionListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import SwiftUI
import DI
import Dtos

public struct EvolutionListView: View {

    typealias EvolutionModelLinked = [Int: [EvolutionModel]]
    
    @Bindable var provider: Provider
    
    public var body: some View {
        VStack {
            if provider.listReady {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(provider.cellProviders, id: \.id) { provider in
                            EvolutionListViewCell(provider: provider)
                        }
                    }
                }
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .frame(height: 120)
    }
    
    @Observable
   public class Provider {
        typealias CellProvider = EvolutionListViewCell.Provider
        var species: SpeciesModel?
        let evolutionChainAPI: PokemonEvolutionChainApi
        let fetchPokemonApi: FetchPokemonApi
        
        var chainBuilder: ChainModelBuilder?
        var evolutionModelsLinked: EvolutionModelLinked
        var listReady: Bool
        var cellProviders: [CellProvider]

        
        init(species: SpeciesModel?, evolutionChainAPI: PokemonEvolutionChainApi, fetchPokemonApi: FetchPokemonApi) {
            self.species = species
            self.evolutionChainAPI = evolutionChainAPI
            self.fetchPokemonApi = fetchPokemonApi

            self.evolutionModelsLinked = .init()
            self.listReady = false
            self.cellProviders = []
            Task {
                await fetch()
            }
        }
        
        func fetch() async {
            guard let species = species else { return }
            let result = await evolutionChainAPI.fetch(query: .init(chainNumber: species.id))
            switch result {
            case .success(let success):
                await buildEvolutionChain(evolutionChain: success)
            case .failure(let failure):
                print(#file,"\n", failure)
            }
        }
        
        func buildEvolutionChain(evolutionChain: EvolutionChain) async {
            var count = 0
            chainBuilder = ChainModelBuilder(current: .init(level: count , current: evolutionChain.chain.species))
            var head = chainBuilder
            // find deep evolutions
            var evolvesTo: [ChainLink] = evolutionChain.chain.evolvesTo
            count += 1
            while !evolvesTo.isEmpty {

                var optionnalsEvolveTo = evolvesTo
                // find optionnal evolutions
                if optionnalsEvolveTo.count > 1 {
                    while !optionnalsEvolveTo.isEmpty {
                        chainBuilder?.options.append(.init(current: .init(level: count, current: optionnalsEvolveTo.removeFirst().species)))
                    }
                    let first = evolvesTo.removeFirst()
                    evolvesTo = first.evolvesTo
                } else {
                    let first = evolvesTo.removeFirst()
                    head?.next = .init(current: .init(level: count, current: first.species))
                    head = head?.next
                    evolvesTo = first.evolvesTo
                }
                count += 1
            }
            await buildProviders(chainBuilder)
        }
        
        func buildProviders(_ chainBuilder: ChainModelBuilder?) async {
            guard let linkedList = chainBuilder?.map() else { return }
            let enumerated = Array(linkedList.sorted(by: { $0.key < $1.key }).enumerated())
            var _providers: [CellProvider] = .init()
            for (_, pair) in enumerated {
                if pair.value.count == 0 {
                    let p: CellProvider = .init(api: fetchPokemonApi, pokemon: .init(index: -1, name: pair.value[0].current.name))
                    _providers.append(p)
                } else {
                    pair.value.forEach { evolutionModel in
                        let p: CellProvider = .init(api: fetchPokemonApi, pokemon: .init(index: -1, name: evolutionModel.current.name))
                        _providers.append(p)
                    }
                }
            }
            let providers = _providers
            await MainActor.run {
                withAnimation {
                    self.cellProviders = providers
                    self.listReady = true
                }
            }
        }
    }
    
    @Observable
   public class ChainModelBuilder {
        var current: EvolutionModel
        var options: [ChainModelBuilder]
        var next: ChainModelBuilder?
        
        init(current: EvolutionModel, next: ChainModelBuilder? = nil) {
            self.current = current
            self.next = next
            self.options = []
        }
        
        func map() -> EvolutionModelLinked {
            var dict = Dictionary.init(grouping: options.map(\.current)) { pair in
                pair.level
            }
            dict[current.level] = [current]
            var head = self
            while let next = head.next {
                if dict[next.current.level] != nil {
                    dict[next.current.level]?.append(next.current)
                } else {
                    dict[next.current.level] = [next.current]
                }
                head = next
            }
            return dict
        }
    }
}

public struct EvolutionModel {
    var level: Int
    var current: NamedAPIResource
}

#Preview {
    @Environment(
        \.diContainer
    ) var container
    
    return EvolutionListView(
        provider: .init(
            species: .init(
                id: "1"
            ),
            evolutionChainAPI: .init(),
            fetchPokemonApi: .init()
        )
    )
    .inject(
        container: container
    )
    .preferredColorScheme(
        .dark
    )
    .environment(
        PokemonDetailsProvider(
            api: .init(),
            speciesApi: .init(),
            evolutionChainApi: .init(),
            abilitiesApi: .init(),
            localPokemon: .init(
                index: 25,
                name: "Pikachu"
            ),
            player: .init()
        )
    )
}
