//
//  AbilityPokemon.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

// MARK: - Pokemon
public struct AbilityPokemon: Codable, Hashable {
    public let isHidden: Bool
    public let pokemon: NamedAPIResource
    public let slot: Int

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon, slot
    }
}
