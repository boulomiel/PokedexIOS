//
//  EvolutionChains.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct EvolutionChain: Codable {
    var babyTriggerItem: NamedAPIResource?
    var chain: ChainLink
    var id: Int

    enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain, id
    }
}

// MARK: - Chain
struct ChainLink: Codable {
    var evolutionDetails: [EvolutionDetail]?
    var evolvesTo: [ChainLink]
    var isBaby: Bool
    var species: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail // Evolution Chain
struct EvolutionDetail: Codable {
    var item : NamedAPIResource?
    var trigger: NamedAPIResource
    var gender: Int?
    var heldItem : NamedAPIResource?
    var knownMove: NamedAPIResource?
    var knownMoveType: NamedAPIResource?
    var location: NamedAPIResource?
    var minLevel: Int?
    var minHappiness: Int?
    var minBeauty: Int?
    var minAffection: Int?
    var needsOverworldRain: Bool
    var partySpecies: NamedAPIResource?
    var partyType: NamedAPIResource?
    var relativePhysicalStats: Int?
    var timeOfDay: String
    var tradeSpecies: NamedAPIResource?
    var turnUpsideDown: Bool

    enum CodingKeys: String, CodingKey {
        case gender
        case heldItem = "held_item"
        case item
        case knownMove = "known_move"
        case knownMoveType = "known_move_type"
        case location
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case partyType = "party_type"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}

struct EvolutionTrigger: Codable {
    var id: Int
    var name: String
    var names: [Name]
    var pokemon_species: [NamedAPIResource]
}
