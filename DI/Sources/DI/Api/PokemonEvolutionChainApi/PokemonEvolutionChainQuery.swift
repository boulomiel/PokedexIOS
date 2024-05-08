//
//  PokemonEvolutionChainQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation
import Resources


public struct PokemonEvolutionChainQuery: ApiQuery {
    let chainNumber: String
    
    public init(chainNumber: String) {
        self.chainNumber = chainNumber
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.evolutionChain.appending("/").appending(chainNumber)
        return components
    }
}
