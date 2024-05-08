//
//  Items.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Item: Codable, Hashable {
    var id: Int
    var name: String
    var cost: Int
    var flingPower: Int?
    var flingEffect: NamedAPIResource?
    var attributes: [NamedAPIResource]
    var category: NamedAPIResource
    var effectEntries: [VerboseEffect]
    var flavorTextEntries: [VersionGroupFlavorText]
    var gameIndices: [GenerationGameIndex]
    var names: [Name]
    var sprites: ItemSprites
    var heldByPokemon: [ItemHolderPokemon]
    var babyTriggerFor: APIResource?
    var machines: [MachineVersionDetail]
    
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
    
    var defaultSprite: URL?
    
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
