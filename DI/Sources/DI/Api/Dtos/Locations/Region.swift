//
//  Region.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Region: Codable {
    
    var id: Int
    var name: String
    var location: [NamedAPIResource]
    var names: [Name]
    var mainGeneration: NamedAPIResource
    var pokedexes: [NamedAPIResource]
    var versionGroups: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, location, name, names
        case mainGeneration = "main_generation"
        case pokedexes
        case versionGroups = "version_groups"
    }
}
