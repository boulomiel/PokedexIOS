//
//  MoveMetaData.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct MoveMetaData: Codable, Hashable {
    
    var ailment: NamedAPIResource // status
    var category: NamedAPIResource
    var min_hits: Int?
    var max_hits: Int?
    var min_turns: Int?
    var max_turns: Int?
    var drain: Int // if is positive drains hp, if negative recoil damage
    var healing: Int
    var crit_rate: Int
    var ailment_chance: Int // The likelihood this attack will cause an ailment.
    var flinch_chance: Int // The likelihood this attack will cause the target Pokémon to flinch.
    var stat_chance: Int // The likelihood this attack will cause a stat change in the target Pokémon.
    
}
