//
//  AbilityFlavorText.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct AbilityFlavorText: Codable, Hashable {
    
    public let flavorText: String
    public let language: NamedAPIResource
    public let versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}
