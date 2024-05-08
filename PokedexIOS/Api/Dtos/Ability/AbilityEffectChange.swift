//
//  AbilityEffectChange.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

// MARK: - EffectChange
public struct AbilityEffectChange: Codable, Hashable {
    var effectEntries: [Effect]
    var versionGroup: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case versionGroup = "version_group"
    }
}
