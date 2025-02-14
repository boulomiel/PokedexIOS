//
//  VersionGameIndex.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct VersionGameIndex: Codable, Hashable, Sendable {
    
    let gameIndex: Int
    let version: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}
