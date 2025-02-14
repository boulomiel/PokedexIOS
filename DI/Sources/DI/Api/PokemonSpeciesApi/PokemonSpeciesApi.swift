//
//  PokemonSpeciesApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation
import Dtos

public final class PokemonSpeciesApi: FetchApiProtocol, Sendable {
    public typealias Query = PokemonSpeciesQuery
    public typealias Requested = PokemonSpecies
    public typealias Failed = ApiPokemonError
    
    public init() {}

}
