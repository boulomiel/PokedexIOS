//
//  Contests.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct ContestType: Codable {
    
    var id: Int
    var name: String
    var berryFlavor: NamedAPIResource
    var names: [ContestName]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case berryFlavor = "berry_flavor"
        case names
    }
}

