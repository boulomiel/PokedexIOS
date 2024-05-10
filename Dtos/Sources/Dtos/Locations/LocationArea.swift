//
//  LocationArea.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct LocationArea: Codable {
    
    var id: Int
    var name: String
    var gameIndex: Int
    var encounterMethodRates: [EncounterMethodRates]
    var location: NamedAPIResource
    var names: [Name]
    var pokemonEncounters: [PokemonEncounter]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case gameIndex = "game_index"
        case encounterMethodRates = "encounter_method_rates"
        case location, names
        case pokemonEncounters = "pokemon_encounters"
    }
}

public struct EncounterMethodRates: Codable {
    
    var encounterMethod: NamedAPIResource
    var versionDetails: [EncounterVersionDetails]
    
    enum CodingKeys: String, CodingKey {
        case encounterMethod = "encounter_method"
        case versionDetails = "versionDetails"
    }
}

public struct EncounterVersionDetails: Codable {
    var rate: Int
    var version: NamedAPIResource
}


public struct PokemonEncounter: Codable {
    var pokemon: NamedAPIResource
    var versionDetails: [VersionEncounterDetail]
    
    enum CodingKeys: String, CodingKey {
        case pokemon
        case versionDetails = "version_details"
    }
}
