//
//  PokemonSpeciesApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public class PokemonSpeciesApi: FetchApiProtocol {
    public typealias Query = PokemonSpeciesQuery
    public typealias Requested = PokemonSpecies
    public typealias Failed = ApiPokemonError
}
