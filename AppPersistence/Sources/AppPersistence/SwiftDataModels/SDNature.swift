//
//  SDStats.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 29/04/2024.
//

import Foundation
import SwiftData
import Dtos

@Model
public class SDNature: SDDataDecoder {
    public typealias Decoded = Nature
    @Attribute(.unique) var natureID: Int
    public var data: Data?
    
    //@Relationship(deleteRule: .nullify, inverse: \SDPokemon.moves)
    public var pokemon: [SDPokemon]?
    
    public init(natureID: Int, data: Data?) {
        self.natureID = natureID
        self.data = data
    }
}

