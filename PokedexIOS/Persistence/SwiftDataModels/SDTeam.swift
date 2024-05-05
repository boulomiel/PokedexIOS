//
//  SDTeam.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

@Model
class SDTeam {
    @Attribute(.unique) let teamID: UUID
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .nullify, inverse: \SDPokemon.team) var pokemons: [SDPokemon]?
    
    init(teamID: UUID = .init(), name: String) {
        self.teamID = teamID
        self.name = name
    }
    
    static var examples: [SDTeam] {
        [
            .init(name: "DreamTeam"),
            .init(name: "LooserTeam"),
            .init(name: "MyFavorites"),
            .init(name: "WaterSwimmer")
        ]
    }
}
