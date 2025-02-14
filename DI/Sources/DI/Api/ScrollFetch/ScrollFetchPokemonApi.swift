//
//  ScrollFetchPokemonApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public final class ScrollFetchPokemonApi: ScrollFetchApiProtocol {
    public  typealias Query = ScrollFetchPokemonQuery
    public typealias Requested = ScrollFetchResult
    public typealias Failed = ApiPokemonError
    
    public init() {}
    
    public func fetch(session: URLSession = .shared, offset: Int) async -> Result<Requested, Failed> {
        let query = ScrollFetchPokemonQuery(limit: 50, offset: offset)
        return await fetch(session: session, query: query)
    }
}
