//
//  VersionGroup.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation


public struct VersionGroup {
    
    var id: Int
    var name: String
    var order: Int
    var generation: NamedAPIResource
    var moveLearnMethods: [NamedAPIResource]
    var pokedexes: [NamedAPIResource]
    var regions: [NamedAPIResource]
    var versions: [NamedAPIResource]
    
    enum CodingKeys: String, CodingKey {
        case id, name, order, generation
        case moveLearnMethods = "move_learn_methods"
        case pokedexes
        case regions
        case versions
    }
}

//GameVersions
//red-blue
//yellow
//gold-silver
//crystal
//ruby-sapphire
//emerald
//firered-leafgreen
//diamond-pearl
//platinum
//heartgold-soulsilver
//black-white
//colosseum
//xd
//black-2-white-2
//x-y
//omega-ruby-alpha-sapphire
//ultra-sun-ultra-moon
//lets-go-pikachu-lets-go-eevee
//sword-shield
