//
//  MoveTarget.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

//Targets moves can be directed at during battle. Targets can be Pokémon, environments or even other moves.

public struct MoveTarget: Codable, Sendable {
    let id: Int
    let name: String
    let descriptions: [Description]
    let moves: [NamedAPIResource]
    let names: [Name]
}
