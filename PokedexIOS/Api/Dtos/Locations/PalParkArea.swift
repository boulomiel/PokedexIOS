//
//  PalParkArea.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct PalParkArea: Codable {
    
    var id: Int
    var name: String
    var names: [Name]
    var pokemonEncounters: [PalParkEncounterSpecies]
    
    enum CodingKeys: String, CodingKey {
        case id, name, names
        case pokemonEncounters = "pokemon_encounters"
    }
    
}

public struct PalParkEncounterSpecies: Codable {
    
    var baseScore: Int
    var rate: Int
    var pokemonSpecies: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case baseScore = "base_score"
        case rate
        case pokemonSpecies = "pokemon_species"
    }
}
