//
//  AbilityFlavorText.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct AbilityFlavorText: Codable, Hashable {
    
    var flavorText: String
    var language: NamedAPIResource
    var versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}
