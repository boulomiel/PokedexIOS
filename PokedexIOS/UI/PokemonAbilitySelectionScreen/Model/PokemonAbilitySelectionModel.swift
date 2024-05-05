//
//  PokemonAbilitySelectionModel.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation

struct PokemonAbilitySelectionModel: Hashable, Identifiable {
    let id: UUID = .init()
    let abilityID: Int
    let name: String
    let isHidden: Bool
    let effectChange: String?
    let effectEntry: String?
    let flavorText: String?
    var abilityData: Data?
}
