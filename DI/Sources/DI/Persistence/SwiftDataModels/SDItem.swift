//
//  HeldItem.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData
import Dtos

@Model
public class SDItem: SDDataDecoder {
    public typealias Decoded = Item
    @Attribute(.unique) var itemID: Int
    public var data: Data?
    
    public var pokemon: [SDPokemon]?
    
    public init(itemID: Int, data: Data?) {
        self.itemID = itemID
        self.data = data
    }
}
