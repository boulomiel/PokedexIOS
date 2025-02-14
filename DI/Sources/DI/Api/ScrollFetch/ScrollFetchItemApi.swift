//
//  ScrollFetchItemApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

public final class ScrollFetchItemApi: ScrollFetchApiProtocol {
    public typealias Query = ScrollFetchItemQuery
    public typealias Requested = ScrollFetchResult
    public typealias Failed = ApiPokemonError
    
    public init() {}
    
    public func fetch(session: URLSession = .shared, offset: Int) async -> Result<Requested, Failed> {
        let query = ScrollFetchItemQuery(limit: 50, offset: offset)
        return await fetch(session: session, query: query)
    }
}
