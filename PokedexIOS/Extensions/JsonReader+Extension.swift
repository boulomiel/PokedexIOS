//
//  JsonReader+Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 08/05/2024.
//

import Foundation
import Resources
import DI
import Dtos

public extension JsonReader {
    
    nonisolated static func readPokemons() -> [Pokemon] {
        return JsonReader.JsonFiles.pokemonFiles.map { self.read(for: $0) }
    }
    
    nonisolated static func readMoves() -> [Move] {
        return JsonReader.JsonFiles.pokemonMoves.map { self.read(for: $0) }
    }
}
