//
//  PlistReader.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public struct PlistReader {
    public enum List: String {
        case pokemonapi
    }
    
    public static func read<T: Codable>(list: List) -> T {
        guard let url = Bundle.module.url(forResource: list.rawValue, withExtension: "plist") else {
            fatalError("Could not find \(list) in bundle")
        }
        let decoder = PropertyListDecoder()
        let data = try! Data(contentsOf: url)
        return try! decoder.decode(T.self, from: data)
    }
}
