//
//  PokemonMoveApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import Foundation
import Dtos

public class PokemonMoveApi: FetchApiProtocol {
    public typealias Requested = Move
    public typealias Query = PokemonMoveQuery
    public typealias Failed = ApiPokemonError
    
    public init() {}
    
}
