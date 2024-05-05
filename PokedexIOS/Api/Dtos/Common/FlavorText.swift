//
//  FlavorTextEntry.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

struct FlavorText: Codable {
    var flavorText: String
    var language, version: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}
