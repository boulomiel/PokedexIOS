//
//  Region.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Region: Codable, Sendable {
    
    let id: Int
    let name: String
    let location: [NamedAPIResource]
    let names: [Name]
    let mainGeneration: NamedAPIResource
    let pokedexes: [NamedAPIResource]
    let versionGroups: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, location, name, names
        case mainGeneration = "main_generation"
        case pokedexes
        case versionGroups = "version_groups"
    }
}
