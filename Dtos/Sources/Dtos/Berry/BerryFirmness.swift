//
//  BerryFirmness.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct BerryFirmness: Codable, Sendable {
    var id: Int
    var name: String
    var berries: [NamedAPIResource]
    var names: [Name]
}
