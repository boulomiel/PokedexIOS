//
//  Encounters.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct EncounterMethod: Codable {
    var id: Int
    var name: String
    var order: Int
    var names: [Name]
}
