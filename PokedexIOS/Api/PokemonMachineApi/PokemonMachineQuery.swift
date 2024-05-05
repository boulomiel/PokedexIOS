//
//  PokemonMachineQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

struct PokemonMachineQuery: ApiQuery, Hashable {
    
    let id: String
    
    var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.machineEndpoint.appending("/").appending(id)
        return components
    }
}
