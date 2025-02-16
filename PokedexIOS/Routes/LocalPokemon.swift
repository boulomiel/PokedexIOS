//
//  LocalPokemon.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public struct LocalPokemon: Identifiable, Codable, Hashable {
    public var id: Int {
        index
    }
    let index: Int
    let name: String
    
    public var species: String {
        if let species = name.split(separator: "-").first {
            String(species)
        } else {
            name
        }
    }
    
    public init(index: Int, name: String) {
        self.index = index
        self.name = name
    }
}
