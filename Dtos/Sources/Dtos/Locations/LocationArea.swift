//
//  LocationArea.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct LocationArea: Codable, Sendable {
    
    let id: Int
    let name: String
    let gameIndex: Int
    let encounterMethodRates: [EncounterMethodRates]
    let location: NamedAPIResource
    let names: [Name]
    let pokemonEncounters: [PokemonEncounter]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case gameIndex = "game_index"
        case encounterMethodRates = "encounter_method_rates"
        case location, names
        case pokemonEncounters = "pokemon_encounters"
    }
}

public struct EncounterMethodRates: Codable, Sendable {
    
    let encounterMethod: NamedAPIResource
    let versionDetails: [EncounterVersionDetails]
    
    enum CodingKeys: String, CodingKey {
        case encounterMethod = "encounter_method"
        case versionDetails = "versionDetails"
    }
}

public struct EncounterVersionDetails: Codable, Sendable {
    let rate: Int
    let version: NamedAPIResource
}


public struct PokemonEncounter: Codable, Sendable {
    let pokemon: NamedAPIResource
    let versionDetails: [VersionEncounterDetail]
    
    enum CodingKeys: String, CodingKey {
        case pokemon
        case versionDetails = "version_details"
    }
}
