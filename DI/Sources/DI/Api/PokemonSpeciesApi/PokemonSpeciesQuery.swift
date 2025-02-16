//
//  PokemonSpeciesQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation
import Resources

public struct PokemonSpeciesQuery: ApiQuery, Sendable {
    let speciesNumber: String
    
    public init(speciesNumber: String) {
        self.speciesNumber = speciesNumber
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.speciesEndpoint.appending("/").appending(speciesNumber)
        return components
    }
}
