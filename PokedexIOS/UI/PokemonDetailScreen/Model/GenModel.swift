//
//  GenModel.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import DI

public struct GenModel: Hashable, Identifiable {
    
    
    public static func == (lhs: GenModel, rhs: GenModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public let id: String
    let sprite: PokemonSprites?
    
    static func generate(from pokemonDTO: Pokemon) -> [GenModel] {
        var genModels: [GenModel] = []
        if let generation1 = pokemonDTO.sprites?.versions?.generationI.yellow, generation1.frontDefault != nil {
            genModels.append(.init(id: "1", sprite: generation1))
        }
        if let generation2 = pokemonDTO.sprites?.versions?.generationIi.crystal, generation2.frontDefault != nil {
            genModels.append(.init(id: "2", sprite: generation2))
        }
        if let generation3 = pokemonDTO.sprites?.versions?.generationIii.emerald, generation3.frontDefault != nil {
            genModels.append(.init(id: "3", sprite: generation3))
        }
        if let generation4 = pokemonDTO.sprites?.versions?.generationIv.diamondPearl, generation4.frontDefault != nil {
            genModels.append(.init(id: "4", sprite: generation4))
        }
        if let generation5 = pokemonDTO.sprites?.versions?.generationV.blackWhite, generation5.frontDefault != nil {
            genModels.append(.init(id: "5", sprite: generation5))
        }
        if let generation6 = pokemonDTO.sprites?.versions?.generationVi.omegaAlpha, generation6.frontDefault != nil {
            genModels.append(.init(id: "6", sprite: generation6))
        }
        if let generation7 = pokemonDTO.sprites?.versions?.generationVii.ultraSunUltraMoon, generation7.frontDefault != nil {
            genModels.append(.init(id: "7", sprite: generation7))
        }
        if let _ = pokemonDTO.sprites?.versions?.generationViii.icons {
            genModels.append(.init(id: "8", sprite: pokemonDTO.sprites))
        }
//        if genModels.isEmpty {
//            genModels.append(.init(name: "8", sprite: pokemonDTO.sprites))
//        }
//        if let generation8 = pokemonDTO.sprites?.versions?.generationViii.icons, generation8.frontDefault != nil {
//            genModels.append(.init(name: "Gen 8", sprite: generation8))
//        }
        return genModels
    }
}
