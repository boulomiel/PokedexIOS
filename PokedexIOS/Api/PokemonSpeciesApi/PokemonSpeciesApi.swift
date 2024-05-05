//
//  PokemonSpeciesApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

class PokemonSpeciesApi: FetchApiProtocol {
    typealias Query = PokemonSpeciesQuery
    typealias Requested = PokemonSpecies
    typealias Failed = ApiPokemonError
}
