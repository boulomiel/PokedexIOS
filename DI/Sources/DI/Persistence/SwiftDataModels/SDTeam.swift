//
//  SDTeam.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

@Model
public class SDTeam {
    @Attribute(.unique) public var teamID: UUID
    public var name: String
    @Relationship(deleteRule: .nullify, inverse: \SDPokemon.team) public var pokemons: [SDPokemon]?
    
    public init(teamID: UUID = .init(), name: String) {
        self.teamID = teamID
        self.name = name
    }
}
