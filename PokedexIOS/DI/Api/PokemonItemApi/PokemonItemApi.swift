//
//  PokemonItemsApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import Dtos

public final class PokemonItemApi: SearchApiProtocol, Sendable {
    public typealias Query = ItemQuery
    public typealias Requested = Item
    public typealias Failed = ApiPokemonError
    
    public init() {}
        
    public func fetch(id: String) async -> Result<Item, ApiPokemonError> {
        let query: Query = .init(itemID: id)
        return await fetch(session: .shared, query: query)
    }
}
