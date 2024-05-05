//
//  LocalPokemon.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

struct LocalPokemon: Identifiable, Codable, Hashable {
    var id: Int {
        index
    }
    let index: Int
    let name: String
}
