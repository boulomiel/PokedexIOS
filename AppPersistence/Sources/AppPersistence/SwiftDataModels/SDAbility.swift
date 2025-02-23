//
//  SDAbility.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import SwiftData
import Dtos

@Model
public class SDAbility: SDDataDecoder {
    public typealias Decoded = Ability
    @Attribute(.unique)
    var abilityID: Int
    public var data: Data?

    public var pokemon: [SDPokemon]?
    
    public init(abilityID: Int, data: Data?) {
        self.abilityID = abilityID
        self.data = data
    }
}

