//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import Dtos

public struct SharedPokemon: Codable {
    public let pokemon: Pokemon?
    public let move: [Move]?
    public let item: Item?
    public let nature: Nature?
    public let ability: Ability?
    
    public init(pokemon: Pokemon?, move: [Move]?, item: Item?, nature: Nature?, ability: Ability?) {
        self.pokemon = pokemon
        self.move = move
        self.item = item
        self.nature = nature
        self.ability = ability
    }
}


