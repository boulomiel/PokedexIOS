//
//  Ability.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Ability: Codable, Hashable {
     public let id: Int
     public let name: String
     public let isMainSeries: Bool
     public let generation: NamedAPIResource
     public let names: [Name]
     public let effectEntries: [VerboseEffect] // talent effect
     public let effectChanges: [AbilityEffectChange] // combat effect
     public let flavorTextEntries: [AbilityFlavorText] // walking around effect
     public let pokemon: [AbilityPokemon]

    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names, pokemon
    }
}

