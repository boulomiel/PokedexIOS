//
//  PokemonEvolutionChainApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

class PokemonEvolutionChainApi: FetchApiProtocol {
    typealias Query = PokemonEvolutionChainQuery
    typealias Requested = EvolutionChain
    typealias Failed = ApiPokemonError
}
