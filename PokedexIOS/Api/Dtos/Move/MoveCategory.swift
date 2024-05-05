//
//  MoveCategory.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct MoveCategory: Codable {
    var id: Int
    var name: String
    var moves: [NamedAPIResource]
    var descriptions: [Description]
}
