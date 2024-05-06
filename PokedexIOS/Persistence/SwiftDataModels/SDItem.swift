//
//  HeldItem.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

@Model
class SDItem: SDDataDecoder {
    typealias Decoded = Item 
    @Attribute(.unique) let itemID: Int
    let data: Data?
    
    var pokemon: [SDPokemon]?
    
    init(itemID: Int, data: Data?) {
        self.itemID = itemID
        self.data = data
    }
}
