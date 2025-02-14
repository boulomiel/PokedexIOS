//
//  SDSpecies.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData
import Dtos

@Model
public class SDSpecies: SDDataDecoder {
    public typealias Decoded = PokemonSpecies
    @Attribute(.unique) var speciesID: Int
    public var data: Data?

    public var pokemon: [SDPokemon]?
    
    public init(speciesID: Int, data: Data?) {
        self.speciesID = speciesID
        self.data = data
    }
}
