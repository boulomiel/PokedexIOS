//
//  ItemPocket.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ItemPocket: Codable, Sendable {
    let id: Int
    let name : String
    let categories: [NamedAPIResource]
    let names: [Name]
}
