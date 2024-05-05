//
//  PokemonQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

struct FetchPokemonQuery: ApiQuery {
    var pokemonID: String
    
    var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.pokemonEndpoint.appending("/").appending(pokemonID)
        return components
    }
}
