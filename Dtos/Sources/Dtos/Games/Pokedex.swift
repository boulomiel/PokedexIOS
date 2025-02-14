//
//  Pokedex.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Pokedex: Codable, Sendable {
    
    let id: Int
    let name: String
    let isMainSeries: Bool
    let descriptions: [Description]
    let names: [Name]
    let pokemonEntries: [PokemonEntry]
    let region: NamedAPIResource
    let versionGroup: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isMainSeries = "is_main_series"
        case descriptions, names
        case pokemonEntries = "pokemon_entries"
        case region
        case versionGroup = "version_groups"
    }
}


public struct PokemonEntry: Codable, Sendable {
    
    let entryNumber: Int
    let pokemonSpecies: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokemonSpecies = "pokemon_species"
    }
}
