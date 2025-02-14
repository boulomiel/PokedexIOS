//
//  Generation.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Generation: Codable, Sendable {
    
    let id: Int
    let name: String
    let abilities:  [NamedAPIResource]
    let names: [Name]
    let mainRegion:  NamedAPIResource
    let moves: [NamedAPIResource]
    let pokemonSpecies: [NamedAPIResource]
    let pokemonType: [NamedAPIResource]
    let versionGroups: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name, abilities, names
        case mainRegion = "main_region"
        case moves
        case pokemonSpecies = "pokemon_species"
        case pokemonType = "type"
        case versionGroups = "version_groups"
    }
}
