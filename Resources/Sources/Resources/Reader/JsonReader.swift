//
//  JsonReader.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation

public final class JsonReader: Sendable {
    
    public enum JsonFiles: String, CaseIterable, Sendable {
        case pikachu = "Pikachu", mew = "Mew", mewtwo = "Mewtwo", bulbasaur = "Bulbasaur", dragonite = "Dragonite", hypno = "Hypno"
        case slam = "Slam", confusion = "Confusion", focusEnergy = "FocusEnergy", swordDance = "SwordDance"
        
        nonisolated(unsafe) public static var pokemonFiles: [JsonFiles] = [.pikachu, .mew, .mewtwo, .bulbasaur, .dragonite, .hypno]
        nonisolated(unsafe) public static var pokemonMoves: [JsonFiles] = [.slam, .confusion, .focusEnergy, .swordDance]
    }
    
    public static func read<T: Decodable>(for file: JsonFiles) -> T {
        guard let url = Bundle.module.url(forResource: file.rawValue, withExtension: "json") else {
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
}
