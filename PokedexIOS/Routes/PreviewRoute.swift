//
//  PreviewRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 25/04/2024.
//

import Foundation
import SwiftData

struct PreviewRoute: Identifiable, Hashable {
    let id: UUID = .init()
    let pokemonID: PersistentIdentifier
}
