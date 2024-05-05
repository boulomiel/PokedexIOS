//
//  MoveDamageClass.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct MoveDamageClass: Codable {
    var id: Int
    var name: String
    var descriptions: [Description]
    var moves: [NamedAPIResource]
    var names: [Name]
}
