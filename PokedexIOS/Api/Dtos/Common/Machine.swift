//
//  Machine.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation
// TH - HM (way to lean moves)
struct Machine: Codable {
    
    var id: Int
    var item: NamedAPIResource
    var move: NamedAPIResource
    var versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, item, move
        case versionGroup = "version_group"
    }
}
