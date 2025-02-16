//
//  CategoryItemQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation
import Resources

public struct CategoryItemQuery: ApiQuery, Sendable {
    let categoryID: String
    
    public init(categoryID: String) {
        self.categoryID = categoryID
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        components.path = api.categorieItemEndpoint.appending("/").appending(categoryID)
        return components
    }
}
