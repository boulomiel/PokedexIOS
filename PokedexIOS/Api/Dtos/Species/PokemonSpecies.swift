//
//  PokemonSpecies.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct PokemonSpecies: Codable {
    var id: Int
    var name: String
    var order: Int
    var gender_rate: Int
    var capture_rate: Int
    var base_happiness: Int?
    var is_baby: Bool?
    var is_legendary: Bool?
    var is_mythical: Bool?
    var hatch_counter: Int?
    var has_gender_differences: Bool
    var forms_switchable: Bool
    var growth_rate: NamedAPIResource
    var pokedex_numbers: [PokemonSpeciesDexEntry]
    var egg_groups: [NamedAPIResource]
    var color: NamedAPIResource
    var shape: NamedAPIResource?
    var evolves_from_species: NamedAPIResource?
    var evolution_chain: APIResource
    var habitat: NamedAPIResource?
    var generation: NamedAPIResource
    var names: [Name]
    var pal_park_encounters: [PalParkEncounterArea]
    var flavor_text_entries: [FlavorText]
    var form_descriptions: [Description]
    var genera: [Genus]
    var varieties: [PokemonSpeciesVariety]
}

struct Genus: Codable {
    var genus: String
    var language: NamedAPIResource
}

struct PokemonSpeciesDexEntry: Codable {
    var entry_number: Int
    var pokedex: NamedAPIResource
}

struct PalParkEncounterArea: Codable {
    var base_score: Int
    var rate: Int
    var area: NamedAPIResource
}

struct PokemonSpeciesVariety: Codable  {
    var is_default: Bool
    var pokemon: NamedAPIResource
}
