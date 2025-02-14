//
//  Nature.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Nature: Codable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let decreased_stat: NamedAPIResource?
    public let increased_stat: NamedAPIResource?
    public let hates_flavor: NamedAPIResource?
    public let likes_flavor: NamedAPIResource?
    public let pokeathlon_stat_changes: [NatureStatChange]
    public let move_battle_style_preferences: [MoveBattleStylePreference]
    public let names: [Name]
}

public struct NatureStatChange: Codable, Hashable, Sendable {
    public let max_change: Int
    public let pokeathlon_stat: NamedAPIResource
}

public struct MoveBattleStylePreference: Codable, Hashable, Sendable {
    public let low_hp_preference: Int
    public let high_hp_preference: Int
    public let move_battle_style: NamedAPIResource
}
