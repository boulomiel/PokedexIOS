//
//  NatureApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation

public class PokemonNatureApi: FetchApiProtocol {
    public typealias Requested = Nature
    public typealias Query = PokemonNatureQuery
    public typealias Failed = ApiPokemonError
    
    public init() {}

}
