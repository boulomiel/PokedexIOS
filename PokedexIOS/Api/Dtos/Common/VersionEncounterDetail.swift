//
//  VersionEncounterDetail.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct VersionEncounterDetail: Codable {
    
    var version: NamedAPIResource
    var maxChance: Int
    var encounterDetails: [Encounter]
    
    enum CodingKeys: String, CodingKey {
        case version
        case maxChance = "max_chance"
        case encounterDetails = "encounter_details"
    }
}
