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
    
    public static func findStringResource(resource: Resources) -> String {
        guard let url = Bundle.module.url(forResource: resource.rawValue, withExtension: resource.ex) else {
            fatalError("Cant find \(resource) in bundle")
        }
        let string = try! String(contentsOf: url)
        return string
    }
}
