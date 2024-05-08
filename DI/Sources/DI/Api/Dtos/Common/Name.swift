//
//  Name.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

// MARK: - Name
public struct Name: Codable, Hashable {
    public let language: NamedAPIResource
    public let name: String
}
