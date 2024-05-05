//
//  PokemonSpeciesQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

struct PokemonSpeciesQuery: ApiQuery {
    let speciesNumber: String
    
    var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.speciesEndpoint.appending("/").appending(speciesNumber)
        return components
    }
}
