//
//  TeamPokemon.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData
import Dtos


@Model
public class SDPokemon: SDDataDecoder {
    public typealias Decoded = Pokemon

    public let pokemonID: Int
    public let data: Data?
    
    @Relationship(deleteRule: .nullify, inverse: \SDMove.pokemon)
    public var moves: [SDMove]?

    public var item: SDItem?
    public var ability: SDAbility?
    public var team: [SDTeam]?
    public var nature: SDNature?
    
    public init(pokemonID: Int, data: Data?) {
        self.pokemonID = pokemonID
        self.data = data
    }
}
