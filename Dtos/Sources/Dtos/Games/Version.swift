//
//  Version.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Version: Codable, Sendable {
    let id: Int
    let name: String
    let names: [Name]
    let versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, name , names
        case versionGroup = "version_group"
    }
}
