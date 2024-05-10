//
//  PokemonCries.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Pokemon: Codable, Hashable {
    public let id: Int
    public let name: String
    public let height: Int
    public let isDefault: Bool
    public let order: Int
    public let weight: Int
    public let abilities: [PokemonAbility]
    public let forms: [NamedAPIResource]
    public let gameIndices: [VersionGameIndex]
    public let heldItems: [PokemonHeldItem]
    public let locationAreaEncounters: URL?
    public let moves: [PokemonMove]
    public let pastTypes: [PokemonTypePast]
    public let sprites: PokemonSprites?
    public let cries: PokemonCries
    public let species: NamedAPIResource
    public let stats: [PokemonStat]
    public let types: [PokemonType]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case height
        case isDefault = "is_default"
        case order, weight, abilities, forms
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves
        case pastTypes = "past_types"
        case sprites, cries, species, stats, types
    }
}

public class PokemonSprites: Codable, Hashable {
    
    public static func == (lhs: PokemonSprites, rhs: PokemonSprites) -> Bool {
        lhs.frontDefault == rhs.frontDefault &&
        lhs.frontShiny == rhs.frontShiny &&
        lhs.frontFemale == rhs.frontFemale &&
        lhs.frontShinyFemale == rhs.frontShinyFemale &&
        lhs.backDefault == rhs.backDefault &&
        lhs.backShiny == rhs.backShiny &&
        lhs.backShinyFemale == rhs.backShinyFemale &&
        lhs.versions == rhs.versions
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(frontDefault)
    }
    
    public let frontDefault: URL?
    public let frontShiny: URL?
    public let frontFemale: URL?
    public let frontShinyFemale: URL?
    public let backDefault: URL?
    public let backShiny: URL?
    public let backFemale: URL?
    public let backShinyFemale: URL?
    public let versions: PokemonVersion?
    public let animated: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case versions, animated
    }
}
// MARK: - Ability
public struct PokemonAbility: Codable, Hashable {
    public let ability: NamedAPIResource
    public let isHidden: Bool
    var slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

public struct PokemonFormType: Codable, Hashable {
    var slot: Int
    var type: NamedAPIResource
}

public struct PokemonTypePast: Codable, Hashable {
    var generation: NamedAPIResource
    var types: [PokemonType]
}

public struct PokemonType: Codable, Hashable {
    var slot: Int
    public let type: NamedAPIResource
}

public struct PokemonHeldItem: Codable, Hashable {
    var item: NamedAPIResource
    var versionDetails: [PokemonHeldItemVersion]

    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

public struct PokemonHeldItemVersion: Codable, Hashable {
    var rarity: Int
    var version: NamedAPIResource
}


public struct PokemonMove: Codable, Hashable {
    public let move: NamedAPIResource
    public let version_group_details: [PokemonMoveVersion]
}

public struct PokemonMoveVersion: Codable, Hashable {
    public  var move_learn_method: NamedAPIResource
    public let version_group: NamedAPIResource
    public let level_learned_at: Int
}


// MARK: - GenerationI
public struct GenerationI: Codable, Hashable {
    public let redBlue, yellow: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - GenerationIi
public struct GenerationIi: Codable, Hashable {
    public let crystal: PokemonSprites?
    public let gold, silver: PokemonSprites?
}

// MARK: - GenerationIii
public struct GenerationIii: Codable, Hashable {
    public let emerald: PokemonSprites?
    public let fireredLeafgreen, rubySapphire: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - GenerationIv
public struct GenerationIv: Codable, Hashable {
    public let diamondPearl, heartgoldSoulsilver, platinum: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - GenerationV
public struct GenerationV: Codable, Hashable {
    public let blackWhite: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - GenerationVii
public struct GenerationVi: Codable, Hashable {
    public let omegaAlpha: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case omegaAlpha = "omegaruby-alphasapphire"
    }
}

// MARK: - GenerationVii
public struct GenerationVii: Codable, Hashable {
    public let icons: PokemonSprites?
    public let ultraSunUltraMoon: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - GenerationViii
public struct GenerationViii: Codable, Hashable {
    public let icons: PokemonSprites?
}

// MARK: - Stat
public struct PokemonStat: Codable, Hashable {
    public let baseStat, effort: Int
    public let stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

public struct PokemonVersion: Codable, Hashable {
    public let generationI: GenerationI
    public let generationIi: GenerationIi
    public let generationIii: GenerationIii
    public let generationIv: GenerationIv
    public let generationV: GenerationV
    public let generationVi: GenerationVi
    public let generationVii: GenerationVii
    public let generationViii: GenerationViii

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

public struct PokemonCries: Codable, Hashable {
    public let latest: URL?
    public let legacy: URL?
}
