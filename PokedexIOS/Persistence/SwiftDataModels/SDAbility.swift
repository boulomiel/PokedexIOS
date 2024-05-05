//
//  SDAbility.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import SwiftData

@Model
class SDAbility: SDDataDecoder {
    typealias Decoded = Ability
    @Attribute(.unique) let abilityID: Int
    let data: Data?

    var pokemon: SDPokemon?
    
    init(abilityID: Int, data: Data?) {
        self.abilityID = abilityID
        self.data = data
    }
    
    init(abilityID: Int, data: Data?, pokemon: SDPokemon?) {
        self.abilityID = abilityID
        self.data = data
        self.pokemon = pokemon
    }
}

