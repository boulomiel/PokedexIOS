//
//  Version.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Version: Codable {
    var id: Int
    var name: String
    var names: [Name]
    var versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, name , names
        case versionGroup = "version_group"
    }
}
