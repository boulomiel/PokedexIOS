//
//  PalParkArea.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct PalParkArea: Codable, Sendable {
    
    let id: Int
    let name: String
    let names: [Name]
    let pokemonEncounters: [PalParkEncounterSpecies]
    
    enum CodingKeys: String, CodingKey {
        case id, name, names
        case pokemonEncounters = "pokemon_encounters"
    }
    
}

public struct PalParkEncounterSpecies: Codable, Sendable {
    
    let baseScore: Int
    let rate: Int
    let pokemonSpecies: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case baseScore = "base_score"
        case rate
        case pokemonSpecies = "pokemon_species"
    }
}
