//
//  PEffectEntries.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

// MARK: - WelcomeEffectEntry
public struct VerboseEffect: Codable, Hashable, Sendable {
    public let effect: String
    public let language: NamedAPIResource
    public let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}
