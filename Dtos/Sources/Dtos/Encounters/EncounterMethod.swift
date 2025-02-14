//
//  Encounters.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct EncounterMethod: Codable, Sendable {
    var id: Int
    var name: String
    var order: Int
    var names: [Name]
}
