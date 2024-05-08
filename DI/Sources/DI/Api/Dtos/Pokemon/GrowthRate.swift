//
//  GrowthRate.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct GrowthRate: Codable {
    var id: Int
    var name: String
    var formula: String // The formula used to calculate the rate at which the Pokémon species gains level.
    var descriptions : [Description]
    var levels: [GrowthRateExperienceLevel]
    var pokemon_species: [NamedAPIResource]
}

public struct GrowthRateExperienceLevel: Codable {
    var level: Int
    var experience: Int
}
