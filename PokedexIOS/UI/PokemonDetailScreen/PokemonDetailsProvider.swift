//
//  PokemonDetailsProvider.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI
import Tools
import DI

@Observable
class PokemonDetailsProvider {
    
    let fetchPokemonApi: FetchPokemonApi
    let speciesApi: PokemonSpeciesApi
    let evolutionChainApi: PokemonEvolutionChainApi
    let abilitiesApi: PokemonAbilityApi

    let localPokemon: LocalPokemon
    let player: CriePlayer
    
    var selectedSegmentURL: URL? {
        segmentProvider?.selected.sprite?.frontDefault
    }
    
    var segmentProvider: PokemonGenerationSegmentView.Provider?
    var evolutionViewProvider: EvolutionListView.Provider?
    var speciesProvider: VarietiesListView<EvolutionListViewCell>.Provider?
    var abilityProvider: PokemonListAbilityView.Provider?
    
    var pokemon: Pokemon?
    var stats: [PokemonDisplayStat]
    var descriptionsByVersions: [DescriptionByVersionModel]
    var moveData: MoveData

    init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, evolutionChainApi: PokemonEvolutionChainApi, abilitiesApi: PokemonAbilityApi, localPokemon: LocalPokemon, player: CriePlayer) {
        self.fetchPokemonApi = api
        self.speciesApi = speciesApi
        self.evolutionChainApi = evolutionChainApi
        self.abilitiesApi = abilitiesApi
        self.localPokemon = localPokemon
        self.player = player
        self.stats = []
        self.descriptionsByVersions = []
        self.moveData = .init(metaVersions: [])
        Task {
            await fetch()
        }
    }
    
    private func fetch() async {
        let result = await fetchPokemonApi.fetch(query: .init(pokemonID: localPokemon.name))
        switch result {
        case .success(let success):
            self.pokemon = success
            Task {
                await player.play(success.cries.latest ?? success.cries.legacy)
            }
            await MainActor.run {
                buildStat(for: success)
                pokemonAbilities(for: success)
                availableVersions(for: success)
                moves(for: success)
            }
            await getEvolutions(for: success)
        case .failure(let failure):
            print(#file,"\n",#function, failure)
        }
    }
    
    private func getEvolutions(for pokemonDTO: Pokemon) async {
        let result = await speciesApi.fetch(query: .init(speciesNumber: pokemonDTO.name))
        switch result {
        case .success(let success):
            await MainActor.run {
                let pathId = success.evolution_chain.url.lastPathComponent
                self.descriptionsByVersions = success.flavor_text_entries.map { text in
                    DescriptionByVersionModel(version: text.version.name, description: text.flavorText, language: text.language.name)
                }
                withAnimation(.bouncy) {
                    if success.varieties.count > 1 {
                        self.speciesProvider = .init(species: .init(id: localPokemon.name), fetchApi: fetchPokemonApi, speciesApi: speciesApi, isGrid: false)
                    }
                    self.evolutionViewProvider = .init(species: .init(id: pathId), evolutionChainAPI: evolutionChainApi, fetchPokemonApi: fetchPokemonApi)
                }
            }
        case .failure(let failure):
            print(#file,"\n",#function, failure, pokemonDTO.name)
        }
    }
    
    private func availableVersions(for pokemonDTO: Pokemon) {
        let genModels = GenModel.generate(from: pokemonDTO)
        var item: GenModel
        switch genModels.count {
        case 2:
            item = genModels[1]
        case 3..<4:
            item = genModels[2]
        case 5...8:
            item = genModels[4]
        default:
            item = genModels[0]
        }
        self.segmentProvider = .init(data: .init(genModels: genModels, selected: item))
    }
    
    private func buildStat(for pokemonDTO: Pokemon) {
        self.stats = pokemonDTO.stats.map { stat in
            PokemonDisplayStat(name: stat.stat.name, value: Double(stat.baseStat)/255) // max pokemon stat 255
        }
    }
    
    private func moves(for pokemonDTO: Pokemon) {
        let datas = pokemonDTO.moves.flatMap { move in
            let meta = Array(Set(move.version_group_details.map {
                MoveVersionMeta(moveName: move.move.name.trimmed,
                                version: .init(rawValue: $0.version_group.name)!,
                                levelLearntAt: $0.level_learned_at,
                                learningMethod: .init(rawValue: $0.move_learn_method.name)!)
            }))
            return meta
        }
        self.moveData.metaVersions = datas
    }
    
    private func pokemonAbilities(for pokemonDTO: Pokemon) {
        let abilities = pokemonDTO.abilities.map { ability in
            PokemonAbilityDetails(name: ability.ability.name, isHidden: ability.isHidden)
        }
        withAnimation(.bouncy) {
            self.abilityProvider = .init(abilityApi: abilitiesApi, abilities: abilities)
        }
    }
}

public struct MoveData: Hashable {
    var metaVersions:  [MoveVersionMeta]
}

public struct MoveItemData: Hashable {
    var querys: PokemonMoveQuery
    var metaVersion: [String : [MoveVersionMeta]]

}

public struct MoveVersionMeta: Hashable {
    var moveName: String
    var version: VersionGroupType
    var levelLearntAt: Int
    var learningMethod: MoveLearnMethodType 
}
