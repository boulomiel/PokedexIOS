//
//  Characteristics.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Characteristics: Codable, Sendable {
    let id: Int
    let gene_modulo: Int
    let possible_values: [Int]
    let highest_stat: NamedAPIResource
    let descriptions: [Description]
}
