//
//  MoveTarget.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

//Targets moves can be directed at during battle. Targets can be Pokémon, environments or even other moves.

public struct MoveTarget: Codable {
    var id: Int
    var name: String
    var descriptions: [Description]
    var moves: [NamedAPIResource]
    var names: [Name]
}
