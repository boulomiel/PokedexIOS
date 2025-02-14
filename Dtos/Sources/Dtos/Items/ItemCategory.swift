//
//  ItemCategories.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ItemCategory: Codable, Sendable {
    public let id: Int
    public let name: String
    public let items: [NamedAPIResource]
    public let names: [Name]
    public let pocket: NamedAPIResource
}
