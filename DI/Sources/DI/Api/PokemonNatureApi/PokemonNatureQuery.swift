//
//  PokemonNatureQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import Resources

public struct PokemonNatureQuery: ApiQuery, Hashable {
    
    let id: String
    
    public init(id: String) {
        self.id = id
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.natureEndpoint.appending("/").appending(id)
        return components
    }
    
    public static var natureRange: Int = 25
}
