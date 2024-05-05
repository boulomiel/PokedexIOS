//
//  Encounter.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct Encounter: Codable {
    
    var minLevel: Int
    var maxLevel: Int
    var conditionValues: EncounterConditionsValues
    var chance: Int
    var method: EncounterMethod
    
    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
        case maxLevel = "max_level"
        case conditionValues = "condition_values"
        case chance, method
    }
}
