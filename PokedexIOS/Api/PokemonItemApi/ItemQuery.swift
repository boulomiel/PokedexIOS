//
//  ItemQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import Resources

public struct ItemQuery: ApiQuery {
    let itemID: String
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.itemEndpoint.appending("/").appending(itemID)
        return components
    }
}
