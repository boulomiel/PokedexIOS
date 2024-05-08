//
//  ScrollFechItemQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import Resources

public struct ScrollFetchItemQuery: ScrolledApiQuery {
    public let limit: Int
    public let offset: Int
    
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
    
    public var urlComponents: URLComponents {
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
