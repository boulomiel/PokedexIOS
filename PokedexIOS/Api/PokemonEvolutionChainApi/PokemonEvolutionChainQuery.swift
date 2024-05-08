//
//  PokemonEvolutionChainQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct PokemonEvolutionChainQuery: ApiQuery {
    let chainNumber: String
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.evolutionChain.appending("/").appending(chainNumber)
        return components
    }
}
