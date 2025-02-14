//
//  Machine.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation
// TH - HM (way to lean moves)
public struct Machine: Codable, Sendable {
    
    public let id: Int
    public let item: NamedAPIResource
    public let move: NamedAPIResource
    public let versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, item, move
        case versionGroup = "version_group"
    }
}
