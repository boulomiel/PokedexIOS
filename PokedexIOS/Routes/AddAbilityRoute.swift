//
//  AddAbilityRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import SwiftData

struct AddAbilityRoute: Hashable, Identifiable {
    let id: UUID = .init()
    let pokemonID: PersistentIdentifier
    let abilities: [PokemonAbility]
    let current: PokemonAbilitySelectionModel?
}
