//
//  SDStats.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import SwiftData

@Model
class SDNature: SDDataDecoder {
    typealias Decoded = Nature
    @Attribute(.unique) let natureID: Int
    let data: Data?
    
    //@Relationship(deleteRule: .nullify, inverse: \SDPokemon.moves)
    var pokemon: SDPokemon?
    
    init(natureID: Int, data: Data?) {
        self.natureID = natureID
        self.data = data
    }
}

