//
//  MoveStatChance.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveStatChange: Codable, Hashable {
    var change: Int
    var stat: NamedAPIResource
}
