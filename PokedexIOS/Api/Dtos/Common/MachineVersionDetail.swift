//
//  MachineVersionDetail.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct MachineVersionDetail: Codable, Hashable {
    var machine: APIResource
    var versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case machine
        case versionGroup = "version_group"
    }
}
