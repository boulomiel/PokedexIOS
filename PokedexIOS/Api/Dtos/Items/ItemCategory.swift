//
//  ItemCategories.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct ItemCategory: Codable {
    var id: Int
    var name: String
    var items: [NamedAPIResource]
    var names: [Name]
    var pocket: NamedAPIResource
}
