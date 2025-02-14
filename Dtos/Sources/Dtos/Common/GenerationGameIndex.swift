//
//  GenerationGameIndex.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct GenerationGameIndex: Codable, Hashable, Sendable {
    
    let gameIndex: Int
    let generation: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case generation
    }
}
