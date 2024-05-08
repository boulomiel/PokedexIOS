//
//  FlavorTextEntry.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct FlavorText: Codable {
    public let flavorText: String
    public let language, version: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}
