//
//  PokeathlonStat.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

//Pokeathlon Stats are different attributes of a Pokémon's performance in Pokéathlons. In Pokéathlons, competitions happen on different courses; one for each of the different Pokéathlon stats

public struct PokeathlonStat: Codable {

    var id: Int
    var name: String
    var names: [Name]
    var affecting_natures: NaturePokeathlonStatAffectSets
    
}

public struct NaturePokeathlonStatAffectSets: Codable {
    var increase: [NamedAPIResource] // A list of natures and how they change the referenced Pokéathlon stat.
    var decrease: [NamedAPIResource] // A list of natures and how they change the referenced Pokéathlon stat.
}

public struct NaturePokeathlonStatAffect: Codable {
    var max_change: Int // The maximum amount of change to the referenced Pokéathlon stat.
    var nature: NamedAPIResource // The nature causing the change.
}
