//
//  BerryFlavors.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct BerryFlavors: Codable {
    var id: Int
    var name: String
    var berries: [BerryFlavorMap]
    var names: [Name]
    var contestType: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, name, berries, names
        case contestType = "contest_type"
    }
}
