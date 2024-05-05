//
//  ScrollFechItemQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation


struct ScrollFetchItemQuery: ScrolledApiQuery {
    let limit: Int
    let offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
    
    func next() -> Self {
        .init(limit: limit, offset: offset + 50)
    }
    
    var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.itemEndpoint
        let queryItems = [URLQueryItem(name: "limit", value: "\(limit)"), URLQueryItem(name: "offset", value: "\(offset)")]
        components.queryItems = queryItems
        return components
    }
}