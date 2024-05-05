//
//  PokemonMachineApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

class PokemonMachineApi: FetchApiProtocol {
    typealias Requested = Machine
    typealias Query = PokemonMachineQuery
    typealias Failed = ApiPokemonError
}
