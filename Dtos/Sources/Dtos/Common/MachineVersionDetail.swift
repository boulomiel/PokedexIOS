//
//  MachineVersionDetail.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MachineVersionDetail: Codable, Hashable {
    public let machine: APIResource
    public let versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case machine
        case versionGroup = "version_group"
    }
}
