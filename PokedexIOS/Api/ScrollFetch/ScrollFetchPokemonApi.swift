//
//  ScrollFetchPokemonApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

class ScrollFetchPokemonApi: ScrollFetchApiProtocol {
    typealias Query = ScrollFetchPokemonQuery
    typealias Requested = ScrollFetchResult
    typealias Failed = ApiPokemonError
    
    func fetch(session: URLSession = .shared, offset: Int) async -> Result<Requested, Failed> {
        let query = ScrollFetchPokemonQuery(limit: 50, offset: offset)
        return await fetch(session: session, query: query)
    }
}
