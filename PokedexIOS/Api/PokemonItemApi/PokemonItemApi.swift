//
//  PokemonItemsApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation

class PokemonItemApi: SearchApiProtocol {
    typealias Query = ItemQuery
    typealias Requested = Item
    typealias Failed = ApiPokemonError
    
    func fetch(id: String) async -> Result<Item, ApiPokemonError> {
        let query: Query = .init(itemID: id)
        return await fetch(session: .shared, query: query)
    }
}
