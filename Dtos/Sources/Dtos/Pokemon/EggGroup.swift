//
//  EggGroup.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct EggGroup: Codable, Sendable {
    let id: Int
    let name: String
    let names: [Name]
    let pokemon_species: [NamedAPIResource]
}
