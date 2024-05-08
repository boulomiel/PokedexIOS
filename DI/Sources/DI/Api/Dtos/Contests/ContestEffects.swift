//
//  ContestEffects.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ContestEffects: Codable {
    
    var id: Int
    var appeal: Int
    var jam: Int
    var effectEntries: [VerboseEffect]
    var flavorTextEntries: [FlavorText]
    
    enum CodingKeys: String, CodingKey {
        case id, appeal, jam
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
    }
}

