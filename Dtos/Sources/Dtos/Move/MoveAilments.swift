//
//  MoveAilments.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

//Move Ailments are status conditions caused by moves used during battle.
public struct MoveAilments: Codable, Sendable {
    let id: Int
    let name: String
    let moves: [NamedAPIResource]
    let names: [Name]
}
