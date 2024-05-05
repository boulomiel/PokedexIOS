//
//  Generation.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct Generation: Codable {
    
    var id: Int
    var name: String
    var abilities:  [NamedAPIResource]
    var names: [Name]
    var mainRegion:  NamedAPIResource
    var moves: [NamedAPIResource]
    var pokemonSpecies: [NamedAPIResource]
    var pokemonType: [NamedAPIResource]
    var versionGroups: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name, abilities, names
        case mainRegion = "main_region"
        case moves
        case pokemonSpecies = "pokemon_species"
        case pokemonType = "type"
        case versionGroups = "version_groups"
    }
}
