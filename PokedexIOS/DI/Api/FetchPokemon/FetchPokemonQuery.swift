//
//  PokemonQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import Resources

public struct FetchPokemonQuery: ApiQuery, Sendable {
    let pokemonID: String
    
    public init(pokemonID: String) {
        self.pokemonID = pokemonID
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.pokemonEndpoint.appending("/").appending(pokemonID)
        return components
    }
}
