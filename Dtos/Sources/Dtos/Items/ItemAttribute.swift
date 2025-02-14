//
//  ItemAttribute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ItemAttribute: Codable, Sendable {
    let id: Int
    let name: String
    let items: [NamedAPIResource]
    let names: [Name]
    let descriptions: [Description]
}
