//
//  GrowthRate.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct GrowthRate: Codable {
    var id: Int
    var name: String
    var formula: String // The formula used to calculate the rate at which the Pokémon species gains level.
    var descriptions : [Description]
    var levels: [GrowthRateExperienceLevel]
    var pokemon_species: [NamedAPIResource]
}

struct GrowthRateExperienceLevel: Codable {
    var level: Int
    var experience: Int
}
