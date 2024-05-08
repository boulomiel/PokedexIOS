//
//  Name.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

// MARK: - Name
public struct Name: Codable, Hashable {
    var language: NamedAPIResource
    var name: String
}
