//
//  TeamPokemon.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

@Model
class SDPokemon: SDDataDecoder {
    typealias Decoded = Pokemon
   // @Attribute(.unique) 
    let pokemonID: Int
    let data: Data?
    @Relationship(deleteRule: .nullify, inverse: \SDMove.pokemon)
    var moves: [SDMove]?
    //@Relationship(deleteRule: .nullify, inverse: \SDItem.pokemon) 
    var item: SDItem?
    var ability: SDAbility?
    var team: [SDTeam]?
    var nature: SDNature?
    
    init(pokemonID: Int, data: Data?, moves: [SDMove]? = nil) {
        self.pokemonID = pokemonID
        self.data = data
        self.moves = moves
    }
}


protocol SDDataDecoder {
    associatedtype Decoded: Decodable
    var data: Data? { get }
}

extension SDDataDecoder {
    var decoded: Decoded? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Decoded.self, from: data)
    }
}
