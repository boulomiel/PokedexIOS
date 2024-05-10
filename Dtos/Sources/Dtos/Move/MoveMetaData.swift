//
//  MoveMetaData.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveMetaData: Codable, Hashable {
    
    public let ailment: NamedAPIResource // status
    public let category: NamedAPIResource
    public let min_hits: Int?
    public let max_hits: Int?
    public let min_turns: Int?
    public let max_turns: Int?
    public let drain: Int // if is positive drains hp, if negative recoil damage
    public let healing: Int
    public let crit_rate: Int
    public let ailment_chance: Int // The likelihood this attack will cause an ailment.
    public let flinch_chance: Int // The likelihood this attack will cause the target Pokémon to flinch.
    public let stat_chance: Int // The likelihood this attack will cause a stat change in the target Pokémon.
    
}
