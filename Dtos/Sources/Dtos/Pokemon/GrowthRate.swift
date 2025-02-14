//
//  GrowthRate.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct GrowthRate: Codable, Sendable {
    let id: Int
    let name: String
    let formula: String // The formula used to calculate the rate at which the Pokémon species gains level.
    let descriptions : [Description]
    let levels: [GrowthRateExperienceLevel]
    let pokemon_species: [NamedAPIResource]
}

public struct GrowthRateExperienceLevel: Codable, Sendable {
    let level: Int
    let experience: Int
}
