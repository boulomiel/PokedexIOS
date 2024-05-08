//
//  Characteristics.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Characteristics: Codable {
    var id: Int
    var gene_modulo: Int
    var possible_values: [Int]
    var highest_stat: NamedAPIResource
    var descriptions: [Description]
}
