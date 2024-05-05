//
//  ItemFlingEffect.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct ItemFlingEffect: Codable {
    var id: Int
    var name: String
    var effect_entries: [Effect]
    var items: [NamedAPIResource]
}
