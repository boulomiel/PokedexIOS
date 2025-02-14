//
//  Encounter.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Encounter: Codable, Sendable {
    
    let minLevel: Int
    let maxLevel: Int
    let conditionValues: EncounterConditionsValues
    let chance: Int
    let method: EncounterMethod
    
    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
        case maxLevel = "max_level"
        case conditionValues = "condition_values"
        case chance, method
    }
}
