//
//  Ability.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct Ability: Codable, Hashable {
    var id: Int
    var name: String
    var isMainSeries: Bool
    var generation: NamedAPIResource
    var names: [Name]
    var effectEntries: [VerboseEffect] // talent effect
    var effectChanges: [AbilityEffectChange] // combat effect
    var flavorTextEntries: [AbilityFlavorText] // walking around effect
    var pokemon: [AbilityPokemon]

    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names, pokemon
    }
}

