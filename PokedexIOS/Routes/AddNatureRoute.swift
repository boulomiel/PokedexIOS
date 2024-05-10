//
//  AddNatureRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import SwiftData
import DI
import Dtos

public struct AddNatureRoute: Hashable, Identifiable {
    public let id: UUID = .init()
    let pokemonID: PersistentIdentifier
    let stats: [PokemonStat]
    let current: Nature?
}
