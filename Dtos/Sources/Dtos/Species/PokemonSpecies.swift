//
//  PokemonSpecies.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct PokemonSpecies: Codable {
    public let id: Int
    public let name: String
    public let order: Int
    public let gender_rate: Int
    public let capture_rate: Int
    public let base_happiness: Int?
    public let is_baby: Bool?
    public let is_legendary: Bool?
    public let is_mythical: Bool?
    public let hatch_counter: Int?
    public let has_gender_differences: Bool
    public let forms_switchable: Bool
    public let growth_rate: NamedAPIResource
    public let pokedex_numbers: [PokemonSpeciesDexEntry]
    public let egg_groups: [NamedAPIResource]
    public let color: NamedAPIResource
    public let shape: NamedAPIResource?
    public let evolves_from_species: NamedAPIResource?
    public let evolution_chain: APIResource
    public let habitat: NamedAPIResource?
    public let generation: NamedAPIResource
    public let names: [Name]
    public let pal_park_encounters: [PalParkEncounterArea]
    public let flavor_text_entries: [FlavorText]
    public let form_descriptions: [Description]
    public let genera: [Genus]
    public let varieties: [PokemonSpeciesVariety]
}

public struct Genus: Codable {
    public let genus: String
    public let language: NamedAPIResource
}

public struct PokemonSpeciesDexEntry: Codable {
    public let entry_number: Int
    public let pokedex: NamedAPIResource
}

public struct PalParkEncounterArea: Codable {
    public let base_score: Int
    public let rate: Int
    public let area: NamedAPIResource
}

public struct PokemonSpeciesVariety: Codable  {
    public let is_default: Bool
    public let pokemon: NamedAPIResource
}
