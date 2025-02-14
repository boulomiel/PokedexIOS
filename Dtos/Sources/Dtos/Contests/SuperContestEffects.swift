//
//  SuperContestEffects.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct SuperContestEffects: Codable, Sendable {
    let id: Int
    let appeal: Int
    let moves: [NamedAPIResource]
    let flavorTextEntries: [FlavorText]
    
    enum CodingKeys: String, CodingKey {
        case id, appeal
        case flavorTextEntries = "flavor_text_entries"
        case moves
    }
}
