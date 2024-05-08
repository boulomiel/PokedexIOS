//
//  FileManagerReader.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public struct PokemonNameReader {
    
    public enum Resources: String {
        case PokemonNames
        
        public var ex: String {
            switch self {
            case .PokemonNames:
                return "txt"
            }
        }
    }
}
