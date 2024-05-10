//
//  PokemonSpeciesApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation
import Dtos

public class PokemonSpeciesApi: FetchApiProtocol {
    public typealias Query = PokemonSpeciesQuery
    public typealias Requested = PokemonSpecies
    public typealias Failed = ApiPokemonError
    
    public init() {}

}
