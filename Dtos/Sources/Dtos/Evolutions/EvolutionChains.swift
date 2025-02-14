//
//  EvolutionChains.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct EvolutionChain: Codable, Sendable {
    public let babyTriggerItem: NamedAPIResource?
    public let chain: ChainLink
    public let id: Int

    enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain, id
    }
}

// MARK: - Chain
public struct ChainLink: Codable, Sendable {
    public let evolutionDetails: [EvolutionDetail]?
    public let evolvesTo: [ChainLink]
    public let isBaby: Bool
    public let species: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail // Evolution Chain
public struct EvolutionDetail: Codable, Sendable {
    public let item : NamedAPIResource?
    public let trigger: NamedAPIResource
    public let gender: Int?
    public let heldItem : NamedAPIResource?
    public let knownMove: NamedAPIResource?
    public let knownMoveType: NamedAPIResource?
    public let location: NamedAPIResource?
    public let minLevel: Int?
    public let minHappiness: Int?
    public let minBeauty: Int?
    public let minAffection: Int?
    public let needsOverworldRain: Bool
    public let partySpecies: NamedAPIResource?
    public let partyType: NamedAPIResource?
    public let relativePhysicalStats: Int?
    public let timeOfDay: String
    public let tradeSpecies: NamedAPIResource?
    public let turnUpsideDown: Bool

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

public struct EvolutionTrigger: Codable, Sendable {
    public let id: Int
    public let name: String
    public let names: [Name]
    public let pokemon_species: [NamedAPIResource]
}
