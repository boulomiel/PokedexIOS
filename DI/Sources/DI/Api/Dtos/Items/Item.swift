//
//  Items.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Item: Codable, Hashable {
    public var id: Int
    public var name: String
    public var cost: Int
    public var flingPower: Int?
    public var flingEffect: NamedAPIResource?
    public var attributes: [NamedAPIResource]
    public var category: NamedAPIResource
    public var effectEntries: [VerboseEffect]
    public var flavorTextEntries: [VersionGroupFlavorText]
    public var gameIndices: [GenerationGameIndex]
    public var names: [Name]
    public var sprites: ItemSprites
    public var heldByPokemon: [ItemHolderPokemon]
    public var babyTriggerFor: APIResource?
    public var machines: [MachineVersionDetail]
    
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

public struct ItemSprites: Codable, Hashable {
    
    public let defaultSprite: URL?
    
    enum CodingKeys: String, CodingKey {
        case defaultSprite = "default"
    }
}

public struct ItemHolderPokemon: Codable, Hashable {
    
    var pokemon: NamedAPIResource
    var versionDetails: [ItemHolderVersionDetail]
    
    enum CodingKeys: String, CodingKey {
        case pokemon
        case versionDetails = "version_details"
    }
}


public struct ItemHolderVersionDetail: Codable, Hashable {
    var rarity: Int
    var version: NamedAPIResource
}


public struct ItemAttributes: Codable, Hashable {
    var id: Int
    var name: String
    var descriptions: ItemAttributesDescription
    var items: [NamedAPIResource]
    var names: [Name]
    
    enum CodingKeys: String, CodingKey {
        case id, name, descriptions, items, names
    }
}

public struct ItemAttributesDescription: Codable, Hashable {
    var description: String
    var language: NamedAPIResource
}
