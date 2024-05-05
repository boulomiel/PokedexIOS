//
//  AddNatureRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import SwiftData

struct AddNatureRoute: Hashable, Identifiable {
    let id: UUID = .init()
    let pokemonID: PersistentIdentifier
    let stats: [PokemonStat]
    let current: Nature?
}
