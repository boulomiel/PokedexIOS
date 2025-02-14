//
//  VersionEncounterDetail.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct VersionEncounterDetail: Codable, Sendable {
    
    let version: NamedAPIResource
    let maxChance: Int
    let encounterDetails: [Encounter]
    
    enum CodingKeys: String, CodingKey {
        case version
        case maxChance = "max_chance"
        case encounterDetails = "encounter_details"
    }
}
