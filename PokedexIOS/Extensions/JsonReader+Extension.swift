//
//  JsonReader+Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 08/05/2024.
//

import Foundation
import Resources

public extension JsonReader {
    
    static func readPokemons() -> [Pokemon] {
        return JsonReader.JsonFiles.pokemonFiles.map { self.read(for: $0) }
    }
    
    static func readMoves() -> [Move] {
        return JsonReader.JsonFiles.pokemonMoves.map { self.read(for: $0) }
    }
}
