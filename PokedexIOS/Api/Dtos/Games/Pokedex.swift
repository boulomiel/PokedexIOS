//
//  Pokedex.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct Pokedex: Codable {
    
    var id: Int
    var name: String
    var isMainSeries: Bool
    var descriptions: [Description]
    var names: [Name]
    var pokemonEntries: [PokemonEntry]
    var region: NamedAPIResource
    var versionGroup: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isMainSeries = "is_main_series"
        case descriptions, names
        case pokemonEntries = "pokemon_entries"
        case region
        case versionGroup = "version_groups"
    }
}


struct PokemonEntry: Codable {
    
    var entryNumber: Int
    var pokemonSpecies: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}
