//
//  Gender.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct Gender: Codable {
    var id: Int
    var name: String
    var pokemon_species_details: [PokemonSpeciesGender]
    var required_for_evolution: [NamedAPIResource]
}

struct PokemonSpeciesGender: Codable {
    var rate: Int
    var pokemon_species: NamedAPIResource
}
