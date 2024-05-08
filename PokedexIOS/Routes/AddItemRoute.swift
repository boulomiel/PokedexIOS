//
//  AddItemRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation
import SwiftData

public struct AddItemRoute: Identifiable, Hashable {
    public let id: UUID = .init()
    var pokemonID: PersistentIdentifier
    var item: Item?
}
