//
//  PokemonAbilityQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

struct PokemonAbilityQuery: ApiQuery {
    let number: String
    
    var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.abilityEndpoint.appending("/").appending(number)
        return components
    }
}