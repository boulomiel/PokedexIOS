//
//  PreviewRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 25/04/2024.
//

import Foundation
import SwiftData

public struct PreviewRoute: Identifiable, Hashable {
    public let id: UUID = .init()
    let pokemonID: PersistentIdentifier
}
