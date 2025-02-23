//
//  PokemonMoveQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import Foundation
import Resources

public struct PokemonMoveQuery: ApiQuery, Hashable, Sendable {
    let moveId: String
    
    public init(moveId: String) {
        self.moveId = moveId
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.moveEndpoint.appending("/").appending(moveId)
        return components
    }
}
