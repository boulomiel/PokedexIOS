//
//  PokemonCategoryItemApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation
import Dtos

public final class PokemonCategoryItemApi: FetchApiProtocol {
    public typealias Query = CategoryItemQuery
    public typealias Requested = ItemCategory
    public typealias Failed = ApiPokemonError
    
    public init() {}
}
