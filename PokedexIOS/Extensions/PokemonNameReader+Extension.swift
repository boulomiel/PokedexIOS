//
//  PokemonNameReader.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation

extension PokemonNameReader {
    private static func findStringResource(resource: Resources) -> String {
        guard let url = Bundle.main.url(forResource: resource.rawValue, withExtension: resource.ex) else {
            fatalError("Cant find \(resource) in bundle")
        }
        let string = try! String(contentsOf: url)
        return string
    }
    
    static func getLocalPokemons() -> [LocalPokemon] {
        let pokeString = findStringResource(resource: .PokemonNames)
        let pokeStringArray = Array(pokeString.split(separator: "\n").enumerated())
        return pokeStringArray.map { index, name in
            LocalPokemon(index: index, name: String(name))
        }
    }
}
