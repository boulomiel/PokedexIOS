//
//  MoveStatChance.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveStatChange: Codable, Hashable, Sendable {
    let change: Int
    let stat: NamedAPIResource
}
