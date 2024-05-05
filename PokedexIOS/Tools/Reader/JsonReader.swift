//
//  JsonReader.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation


struct JsonReader {
    
    enum JsonFiles: String, CaseIterable {
        case pikachu = "Pikachu", mew = "Mew", mewtwo = "Mewtwo", bulbasaur = "Bulbasaur", dragonite = "Dragonite", hypno = "Hypno"
        case slam = "Slam", confusion = "Confusion", focusEnergy = "FocusEnergy", swordDance = "SwordDance"
        
        static var pokemonFiles: [JsonFiles] = [.pikachu, .mew, .mewtwo, .bulbasaur, .dragonite, .hypno]
        static var pokemonMoves: [JsonFiles] = [.slam, .confusion, .focusEnergy, .swordDance]
    }
    
    static func read<T: Decodable>(for file: JsonFiles) -> T {
        guard let url = Bundle.main.url(forResource: file.rawValue, withExtension: "json") else {
            fatalError("This file \(file.rawValue) cannot be found within the package")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("This file \(file.rawValue) is not a readable json")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("\(error)")
        }
    }
    
    static func readPokemons() -> [Pokemon] {
        return JsonFiles.pokemonFiles.map { self.read(for: $0) }
    }
    
    static func readMoves() -> [Move] {
        return JsonFiles.pokemonMoves.map { self.read(for: $0) }
    }
}
