//
//  SuperContestEffects.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct SuperContestEffects: Codable {
    var id: Int
    var appeal: Int
    var moves: [NamedAPIResource]
    var flavorTextEntries: [FlavorText]
    
    enum CodingKeys: String, CodingKey {
        case id, appeal
        case flavorTextEntries = "flavor_text_entries"
        case moves
    }
}
