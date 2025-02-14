//
//  MoveDamageClass.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveDamageClass: Codable, Sendable {
    let id: Int
    let name: String
    let descriptions: [Description]
    let moves: [NamedAPIResource]
    let names: [Name]
}
