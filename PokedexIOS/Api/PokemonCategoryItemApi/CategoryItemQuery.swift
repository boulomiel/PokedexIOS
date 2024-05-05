//
//  CategoryItemQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

struct CategoryItemQuery: ApiQuery {
    let categoryID: String
    
    var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.categorieItemEndpoint.appending("/").appending(categoryID)
        return components
    }
}
