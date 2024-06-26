//
//  SDSpecies.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

@Model
class SDSpecies: SDDataDecoder {
    typealias Decoded = PokemonSpecies
    @Attribute(.unique) let speciesID: Int
    let data: Data?

    var pokemon: [SDPokemon]?
    
    init(speciesID: Int, data: Data?) {
        self.speciesID = speciesID
        self.data = data
    }
}
