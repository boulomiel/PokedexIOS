//
//  PokemonMachineApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation
import Dtos

public class PokemonMachineApi: FetchApiProtocol {
    public typealias Requested = Machine
    public typealias Query = PokemonMachineQuery
    public typealias Failed = ApiPokemonError
    
    public init() {}

}
