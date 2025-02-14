//
//  ItemFlingEffect.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ItemFlingEffect: Codable, Sendable {
    let id: Int
    let name: String
    let effect_entries: [Effect]
    let items: [NamedAPIResource]
}
