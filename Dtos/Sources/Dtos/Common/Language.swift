//
//  Languages.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Language: Codable, Sendable {
    let id: Int
    let name: String
    let official: Bool
    let iso639: String
    let iso3166: String
    let names: [Name]
}
