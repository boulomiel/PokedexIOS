//
//  FetchPokemonApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import Dtos

public class FetchPokemonApi: SearchApiProtocol {
    public typealias Query = FetchPokemonQuery
    public typealias Requested = Pokemon
    public typealias Failed = ApiPokemonError
    
    public init() {}
    
    public func fetch(id: String) async -> Result<Requested, Failed> {
        let query: Query = .init(pokemonID: id)
        return await fetch(session: .shared, query: query)
    }
}

