//
//  Location.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct Location: Codable, Sendable {
    let id: Int
    let name: String
    let region: NamedAPIResource
    let names: [Name]
    let gameIndices: GenerationGameIndex
    let areas: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name, region, names
        case gameIndices = "game_indices"
        case areas
    }
}
