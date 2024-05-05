//
//  AddTeamRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

struct AddTeamRoute: Identifiable,  Hashable {
    static func == (lhs: AddTeamRoute, rhs: AddTeamRoute) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: UUID = .init()
    var selectedPokemons: [Pokemon] = []
    var teamID: PersistentIdentifier?
}
