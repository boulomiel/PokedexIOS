//
//  Nature.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Nature: Codable, Hashable {
    var id: Int
    var name: String
    var decreased_stat: NamedAPIResource?
    var increased_stat: NamedAPIResource?
    var hates_flavor: NamedAPIResource?
    var likes_flavor: NamedAPIResource?
    var pokeathlon_stat_changes: [NatureStatChange]
    var move_battle_style_preferences: [MoveBattleStylePreference]
    var names: [Name]
}

public struct NatureStatChange: Codable, Hashable {
    var max_change: Int
    var pokeathlon_stat: NamedAPIResource
}

public struct MoveBattleStylePreference: Codable, Hashable {
    var low_hp_preference: Int
    var high_hp_preference: Int
    var move_battle_style: NamedAPIResource
}
