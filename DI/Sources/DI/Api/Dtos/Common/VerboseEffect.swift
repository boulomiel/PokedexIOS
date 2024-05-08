//
//  PEffectEntries.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

// MARK: - WelcomeEffectEntry
public struct VerboseEffect: Codable, Hashable {
    public  var effect: String
    public var language: NamedAPIResource
    public var shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}
