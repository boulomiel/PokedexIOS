//
//  PlistReader+Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation

extension PlistReader {
    public static func read<T: Codable>(list: List) -> T {
        guard let url = Bundle.main.url(forResource: list.rawValue, withExtension: "plist") else {
            fatalError("Could not find \(list) in bundle")
        }
        let decoder = PropertyListDecoder()
        let data = try! Data(contentsOf: url)
        return try! decoder.decode(T.self, from: data)
    }
}
