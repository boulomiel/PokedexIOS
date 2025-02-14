//
//  MoveCategory.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveCategory: Codable, Sendable {
    let id: Int
    let name: String
    let moves: [NamedAPIResource]
    let descriptions: [Description]
}
