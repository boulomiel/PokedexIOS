//
//  PastMoveTypeValues.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

struct Move: Codable, Identifiable, Hashable {
    
    
    var id: Int
    var name: String
    var accuracy: Int?
    var effectChance: Int?
    var pp: Int
    var priority: Int
    var power: Int?
   // var contestCombos: ContestComboSet?
   // var contestType: NamedAPIResource?
   // var contestEffect: APIResource?
    var damageClass: NamedAPIResource
    var effectEntries: [VerboseEffect]
    //var effectChanges: [NamedAPIResource]
    var learnedByPokemon: [NamedAPIResource]
    let flavorTextEntries: [MoveFlavorText]
    var generation: NamedAPIResource
    var machines: [MachineVersionDetail]
    var meta: MoveMetaData?
    var names: [Name]
    var pastValues: [PastMoveValues]
    var statChanges: [MoveStatChange]
   // var superContestEffect: APIResource
    var target: NamedAPIResource
    var type: NamedAPIResource
    
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


struct ContestComboSet: Codable, Hashable {
    
    var normal: ContestComboDetail?
    var _super: ContestComboDetail?
    
    enum CodingKeys: String, CodingKey {
        case normal
        case _super = "super"
    }
}

struct ContestComboDetail: Codable, Hashable {
    
    var useBefore: NamedAPIResource?
    var useAfter: NamedAPIResource?
    
    enum CodingKeys: String, CodingKey {
        case useBefore = "user_before"
        case useAfter = "user_after"
    }
}


struct MoveFlavorText: Codable, Hashable {
    
    var flavorText: String
    var language: NamedAPIResource
    var versionGroup: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language = "language"
        case versionGroup = "version_group"
    }
}
