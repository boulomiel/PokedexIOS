//
//  PokeathlonStat.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

//Pokeathlon Stats are different attributes of a Pokémon's performance in Pokéathlons. In Pokéathlons, competitions happen on different courses; one for each of the different Pokéathlon stats

public struct PokeathlonStat: Codable, Sendable {

    let id: Int
    let name: String
    let names: [Name]
    let affecting_natures: NaturePokeathlonStatAffectSets
    
}

public struct NaturePokeathlonStatAffectSets: Codable, Sendable {
    let increase: [NamedAPIResource] // A list of natures and how they change the referenced Pokéathlon stat.
    let decrease: [NamedAPIResource] // A list of natures and how they change the referenced Pokéathlon stat.
}

public struct NaturePokeathlonStatAffect: Codable, Sendable {
    let max_change: Int // The maximum amount of change to the referenced Pokéathlon stat.
    let nature: NamedAPIResource // The nature causing the change.
}
