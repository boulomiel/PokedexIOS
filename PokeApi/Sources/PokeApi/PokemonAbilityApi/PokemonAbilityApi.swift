//
//  PokemonAbilityApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation
import Dtos

public final class PokemonAbilityApi: FetchApiProtocol {
    public typealias Query = PokemonAbilityQuery
    public typealias Requested = Ability
    public typealias Failed = ApiPokemonError
    
    public init() {}

}
