//
//  EncounterConditions.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct EncounterConditions: Codable, Sendable {
    let id: Int
    let name: String
    let values: [NamedAPIResource]
    let names: [Name]
}
