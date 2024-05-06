//
//  PokemonMove.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

@Model
class SDMove: SDDataDecoder {
    typealias Decoded = Move
    @Attribute(.unique) let moveID: Int
    let data: Data?
    
    //@Relationship(deleteRule: .nullify, inverse: \SDPokemon.moves)
    var pokemon: [SDPokemon]?
    
    init(moveID: Int, data: Data?) {
        self.moveID = moveID
        self.data = data
    }
}
