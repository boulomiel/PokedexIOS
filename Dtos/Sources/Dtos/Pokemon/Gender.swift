//
//  Gender.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Gender: Codable, Sendable {
    let id: Int
    let name: String
    let pokemon_species_details: [PokemonSpeciesGender]
    let required_for_evolution: [NamedAPIResource]
}

public struct PokemonSpeciesGender: Codable, Sendable {
    let rate: Int
    let pokemon_species: NamedAPIResource
}
