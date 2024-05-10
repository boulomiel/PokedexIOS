//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation

public struct SharedTeam: Codable {
    public let name: String
    public let pokemons: [SharedPokemon]
    
    public init(name: String, pokemons: [SharedPokemon]) {
        self.name = name
        self.pokemons = pokemons
    }
    
}
