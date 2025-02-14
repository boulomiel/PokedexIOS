//
//  PastMoveValues.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct PastMoveValues: Codable, Hashable, Sendable {
    let accuracy: Int?
    let effect_chance: Int?
    let power: Int?
    let pp: Int?
    let effect_entries: [VerboseEffect]
    let type: NamedAPIResource?
    let version_group: NamedAPIResource
}
