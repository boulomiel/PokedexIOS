//
//  NatureApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation

class PokemonNatureApi: FetchApiProtocol {
    typealias Requested = Nature
    typealias Query = PokemonNatureQuery
    typealias Failed = ApiPokemonError
}
