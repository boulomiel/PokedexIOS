//
//  EncounterConditionsValues.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct EncounterConditionsValues: Codable {
    var id: Int
    var name: String
    var values: [NamedAPIResource]
    var names: [Name]
}
