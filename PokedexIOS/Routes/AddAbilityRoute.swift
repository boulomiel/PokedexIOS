//
//  AddAbilityRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import SwiftData
import DI

public struct AddAbilityRoute: Hashable, Identifiable {
    public let id: UUID = .init()
    let pokemonID: PersistentIdentifier
    let abilities: [PokemonAbility]
    let current: PokemonAbilitySelectionModel?
}
