//
//  PastMoveTypeValues.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct Move: Codable, Identifiable, Hashable, Sendable {
    
    public let id: Int
    public let name: String
    public let accuracy: Int?
    public let effectChance: Int?
    public let pp: Int
    public let priority: Int
    public let power: Int?
    //  let contestCombos: ContestComboSet?
    //  let contestType: NamedAPIResource?
    //  let contestEffect: APIResource?
    public let damageClass: NamedAPIResource
    public let effectEntries: [VerboseEffect]
    // let effectChanges: [NamedAPIResource]
    public let learnedByPokemon: [NamedAPIResource]
    public let flavorTextEntries: [MoveFlavorText]
    public let generation: NamedAPIResource
    public let machines: [MachineVersionDetail]
    public let meta: MoveMetaData?
    public let names: [Name]
    public let pastValues: [PastMoveValues]
    public let statChanges: [MoveStatChange]
    //  let superContestEffect: APIResource
    public let target: NamedAPIResource
    public let type: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case id, name, accuracy
        case effectChance = "effect_chance"
        case pp, priority, power
        // case contestCombos = "contest_combos"
        // case contestType = "contest_type"
        // case contestEffect = "contest_effect"
        case damageClass = "damage_class"
        case effectEntries = "effect_entries"
        // case effectChanges = "effect_changes"
        case learnedByPokemon = "learned_by_pokemon"
        case flavorTextEntries = "flavor_text_entries"
        case generation
        case machines
        case meta, names
        case pastValues = "past_values"
        case statChanges = "stat_changes"
        //   case superContestEffect = "super_contest_effect"
        case target, type
    }
}


public struct ContestComboSet: Codable, Hashable, Sendable {
    
    public let normal: ContestComboDetail?
    public let _super: ContestComboDetail?
    
    enum CodingKeys: String, CodingKey {
        case normal
        case _super = "super"
    }
}

public struct ContestComboDetail: Codable, Hashable, Sendable {
    
    public let useBefore: NamedAPIResource?
    public let useAfter: NamedAPIResource?
    
    enum CodingKeys: String, CodingKey {
        case useBefore = "user_before"
        case useAfter = "user_after"
    }
}


public struct MoveFlavorText: Codable, Hashable, Sendable {
    
    public let flavorText: String
    public let language: NamedAPIResource
    public let versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language = "language"
        case versionGroup = "version_group"
    }
}
