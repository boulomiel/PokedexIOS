//
//  ContestName.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct ContestName: Codable, Sendable {
    let name: String
    let color: String
    let language: NamedAPIResource
}
