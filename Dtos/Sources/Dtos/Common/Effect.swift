//
//  Effect.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Effect: Codable, Hashable, Sendable {
    public let effect: String
    public let language: NamedAPIResource
}
