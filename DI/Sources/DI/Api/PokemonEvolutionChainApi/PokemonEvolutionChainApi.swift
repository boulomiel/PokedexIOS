//
//  PokemonEvolutionChainApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation
import Dtos

public class PokemonEvolutionChainApi: FetchApiProtocol {
    public typealias Query = PokemonEvolutionChainQuery
    public typealias Requested = EvolutionChain
    public typealias Failed = ApiPokemonError
    
    public init() {}

}
