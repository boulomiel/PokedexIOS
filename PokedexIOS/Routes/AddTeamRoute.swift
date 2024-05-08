//
//  AddTeamRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData
import DI

public struct AddTeamRoute: Identifiable,  Hashable {
    public static func == (lhs: AddTeamRoute, rhs: AddTeamRoute) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public let id: UUID = .init()
    var selectedPokemons: [Pokemon] = []
    var teamID: PersistentIdentifier?
}
