//
//  VersionGroupFlavorText.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct VersionGroupFlavorText: Codable, Hashable {
    
    public var text: String
    public var language: NamedAPIResource
    public var versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case text
        case language
        case versionGroup = "version_group"
    }
}
