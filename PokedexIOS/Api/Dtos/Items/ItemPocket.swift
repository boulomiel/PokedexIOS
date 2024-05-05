//
//  ItemPocket.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct ItemPocket: Codable {
    var id: Int
    var name : String
    var categories: [NamedAPIResource]
    var names: [Name]
}
