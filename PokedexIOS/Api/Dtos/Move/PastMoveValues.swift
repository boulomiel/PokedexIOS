//
//  PastMoveValues.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct PastMoveValues: Codable, Hashable {
    var accuracy: Int?
    var effect_chance: Int?
    var power: Int?
    var pp: Int?
    var effect_entries: [VerboseEffect]
    var type: NamedAPIResource?
    var version_group: NamedAPIResource
}
