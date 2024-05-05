//
//  AddItemRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation
import SwiftData

struct AddItemRoute: Identifiable, Hashable {
    let id: UUID = .init()
    var pokemonID: PersistentIdentifier
    var item: Item?
}
