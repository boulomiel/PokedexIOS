//
//  SDSpecies.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

@Model
public class SDSpecies: SDDataDecoder {
    public typealias Decoded = PokemonSpecies
    @Attribute(.unique) let speciesID: Int
    public let data: Data?

    public var pokemon: [SDPokemon]?
    
    public init(speciesID: Int, data: Data?) {
        self.speciesID = speciesID
        self.data = data
    }
}
