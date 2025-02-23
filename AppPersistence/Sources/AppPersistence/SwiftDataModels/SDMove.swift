//
//  PokemonMove.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData
import Dtos


@Model
public class SDMove: SDDataDecoder {
    public typealias Decoded = Move
    @Attribute(.unique) var moveID: Int
    public var data: Data?
    
    //@Relationship(deleteRule: .nullify, inverse: \SDPokemon.moves)
    public var pokemon: [SDPokemon]?
    
    public init(moveID: Int, data: Data?) {
        self.moveID = moveID
        self.data = data
    }
}
