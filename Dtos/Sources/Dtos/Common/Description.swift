//
//  Description.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Description: Codable, Sendable {
    let description: String
    let language: NamedAPIResource
}
