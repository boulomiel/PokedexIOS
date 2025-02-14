//
//  Items.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Item: Codable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let cost: Int
    public let flingPower: Int?
    public let flingEffect: NamedAPIResource?
    public let attributes: [NamedAPIResource]
    public let category: NamedAPIResource
    public let effectEntries: [VerboseEffect]
    public let flavorTextEntries: [VersionGroupFlavorText]
    public let gameIndices: [GenerationGameIndex]
    public let names: [Name]
    public let sprites: ItemSprites
    public let heldByPokemon: [ItemHolderPokemon]
    public let babyTriggerFor: APIResource?
    public let machines: [MachineVersionDetail]
    
    enum CodingKeys: String, CodingKey {
        case id, name, cost
        case flingPower = "fling_power"
        case flingEffect = "fling_effect"
        case attributes
        case category
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case gameIndices = "game_indices"
        case names
        case sprites
        case heldByPokemon = "held_by_pokemon"
        case babyTriggerFor = "baby_trigger_for"
        case machines
    }
}

extension Item {
    var categoryType: ItemCategoryApiResource {
        .init(name: ItemCategoryType(stringValue: category.name), url: category.url)
    }
}

public struct ItemSprites: Codable, Hashable, Sendable {
    
    public let defaultSprite: URL?
    
    enum CodingKeys: String, CodingKey {
        case defaultSprite = "default"
    }
}

public struct ItemHolderPokemon: Codable, Hashable, Sendable {
    
    let pokemon: NamedAPIResource
    let versionDetails: [ItemHolderVersionDetail]
    
    enum CodingKeys: String, CodingKey {
        case pokemon
        case versionDetails = "version_details"
    }
}


public struct ItemHolderVersionDetail: Codable, Hashable, Sendable {
    let rarity: Int
    let version: NamedAPIResource
}


public struct ItemAttributes: Codable, Hashable, Sendable {
    let id: Int
    let name: String
    let descriptions: ItemAttributesDescription
    let items: [NamedAPIResource]
    let names: [Name]
    
    enum CodingKeys: String, CodingKey {
        case id, name, descriptions, items, names
    }
}

public struct ItemAttributesDescription: Codable, Hashable, Sendable {
    let description: String
    let language: NamedAPIResource
}
