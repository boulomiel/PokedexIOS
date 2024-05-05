//
//  PokemonMoveApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import Foundation

class PokemonMoveApi: FetchApiProtocol {
    typealias Requested = Move
    typealias Query = PokemonMoveQuery
    typealias Failed = ApiPokemonError
    
}
