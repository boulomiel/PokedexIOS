//
//  PokemonNameReader.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import Resources

public extension PokemonNameReader {

    static func getLocalPokemons() -> [LocalPokemon] {
        let pokeString = findStringResource(resource: .PokemonNames)
        let pokeStringArray = Array(pokeString.split(separator: "\n").enumerated())
        return pokeStringArray.map { index, name in
            LocalPokemon(index: index, name: String(name))
        }
    }
}
