//
//  PokemonCategoryItemApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

class PokemonCategoryItemApi: FetchApiProtocol {
    typealias Query = CategoryItemQuery
    typealias Requested = ItemCategory
    typealias Failed = ApiPokemonError
}
