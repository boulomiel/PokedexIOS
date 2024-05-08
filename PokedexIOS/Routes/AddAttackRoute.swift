//
//  AddAttackRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

public struct AddAttackRoute: Identifiable, Hashable {
    public let id: UUID = .init()
    let pokemonID: PersistentIdentifier
    let movesURL: [URL]
    let selectedMoves: [Move]
}
