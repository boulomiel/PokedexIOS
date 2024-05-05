//
//  ScrollFetchItemApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

class ScrollFetchItemApi: ScrollFetchApiProtocol {
    typealias Query = ScrollFetchItemQuery
    typealias Requested = ScrollFetchResult
    typealias Failed = ApiPokemonError
    
    func fetch(session: URLSession = .shared, offset: Int) async -> Result<Requested, Failed> {
        let query = ScrollFetchItemQuery(limit: 50, offset: offset)
        return await fetch(session: session, query: query)
    }
}
