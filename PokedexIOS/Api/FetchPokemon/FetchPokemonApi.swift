//
//  FetchPokemonApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

class FetchPokemonApi: SearchApiProtocol {
    typealias Query = FetchPokemonQuery
    typealias Requested = Pokemon
    typealias Failed = ApiPokemonError
    
    func fetch(id: String) async -> Result<Requested, Failed> {
        let query: Query = .init(pokemonID: id)
        return await fetch(session: .shared, query: query)
    }
}

