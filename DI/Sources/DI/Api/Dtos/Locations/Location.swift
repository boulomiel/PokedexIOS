//
//  Location.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct Location: Codable {
    var id: Int
    var name: String
    var region: NamedAPIResource
    var names: [Name]
    var gameIndices: GenerationGameIndex
    var areas: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name, region, names
        case gameIndices = "game_indices"
        case areas
    }
}
