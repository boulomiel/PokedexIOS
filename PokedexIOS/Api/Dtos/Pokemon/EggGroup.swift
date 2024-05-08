//
//  EggGroup.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct EggGroup: Codable {
    var id: Int
    var name: String
    var names: [Name]
    var pokemon_species: [NamedAPIResource]
}
