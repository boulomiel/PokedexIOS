//
//  PokemonAbilityApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

class PokemonAbilityApi: FetchApiProtocol {
    typealias Query = PokemonAbilityQuery
    typealias Requested = Ability
    typealias Failed = ApiPokemonError
}
