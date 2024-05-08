//
//  PokemonCries.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct Pokemon: Codable, Hashable {
    var id: Int
    var name: String
    var height: Int
    var isDefault: Bool
    var order: Int
    var weight: Int
    var abilities: [PokemonAbility]
    var forms: [NamedAPIResource]
    var gameIndices: [VersionGameIndex]
    var heldItems: [PokemonHeldItem]
    var locationAreaEncounters: URL?
    var moves: [PokemonMove]
    var pastTypes: [PokemonTypePast]
    var sprites: PokemonSprites?
    var cries: PokemonCries
    var species: NamedAPIResource
    var stats: [PokemonStat]
    var types: [PokemonType]
    
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

class PokemonSprites: Codable, Hashable {
    
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
    
    var frontDefault: URL?
    var frontShiny: URL?
    var frontFemale: URL?
    var frontShinyFemale: URL?
    var backDefault: URL?
    var backShiny: URL?
    var backFemale: URL?
    var backShinyFemale: URL?
    var versions: PokemonVersion?
    var animated: PokemonSprites?

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
    var ability: NamedAPIResource
    var isHidden: Bool
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
    var type: NamedAPIResource
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
    var move: NamedAPIResource
    var version_group_details: [PokemonMoveVersion]
}

public struct PokemonMoveVersion: Codable, Hashable {
    var move_learn_method: NamedAPIResource
    var version_group: NamedAPIResource
    var level_learned_at: Int
}


// MARK: - GenerationI
public struct GenerationI: Codable, Hashable {
    var redBlue, yellow: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - GenerationIi
public struct GenerationIi: Codable, Hashable {
    var crystal: PokemonSprites?
    var gold, silver: PokemonSprites?
}

// MARK: - GenerationIii
public struct GenerationIii: Codable, Hashable {
    var emerald: PokemonSprites?
    var fireredLeafgreen, rubySapphire: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - GenerationIv
public struct GenerationIv: Codable, Hashable {
    var diamondPearl, heartgoldSoulsilver, platinum: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - GenerationV
public struct GenerationV: Codable, Hashable {
    var blackWhite: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - GenerationVii
public struct GenerationVi: Codable, Hashable {
    var omegaAlpha: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case omegaAlpha = "omegaruby-alphasapphire"
    }
}

// MARK: - GenerationVii
public struct GenerationVii: Codable, Hashable {
    var icons: PokemonSprites?
    var ultraSunUltraMoon: PokemonSprites?

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - GenerationViii
public struct GenerationViii: Codable, Hashable {
    var icons: PokemonSprites?
}

// MARK: - Stat
public struct PokemonStat: Codable, Hashable {
    var baseStat, effort: Int
    var stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

public struct PokemonVersion: Codable, Hashable {
    var generationI: GenerationI
    var generationIi: GenerationIi
    var generationIii: GenerationIii
    var generationIv: GenerationIv
    var generationV: GenerationV
    var generationVi: GenerationVi
    var generationVii: GenerationVii
    var generationViii: GenerationViii

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
    var latest: URL?
    var legacy: URL?
}
