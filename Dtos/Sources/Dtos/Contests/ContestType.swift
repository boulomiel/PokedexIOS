//
//  Contests.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ContestType: Codable, Sendable {
    
    let id: Int
    let name: String
    let berryFlavor: NamedAPIResource
    let names: [ContestName]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case berryFlavor = "berry_flavor"
        case names
    }
}

