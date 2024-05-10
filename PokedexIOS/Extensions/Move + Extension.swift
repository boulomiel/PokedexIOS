//
//  Move + Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import DI
import SwiftUI
import Dtos

public extension Move {
    
    var dataHolder: MoveItemDataHolder {
        MoveItemDataHolder(
            id: id,
            name: names.map { MoveNameItem(name: $0.name, language: $0.language.name) },
            effects: effectEntries.map { MoveEffectItem(effect: $0.shortEffect, language: $0.language.name) },
            type: type.name,
            damageClass: .init(rawValue: damageClass.name),
            generation: generation.name,
            drain: meta?.drain,
            healing: meta?.healing,
            critRate: meta?.crit_rate,
            ailmentChance: meta?.ailment_chance,
            flintChance: meta?.flinch_chance,
            statChance: meta?.stat_chance,
            learntBy: learnedByPokemon.map(\.name),
            priority: priority,
            pp: pp,
            power: power
            
        )
    }
    
    func Icon(_ size: CGFloat) -> some View {
        Image(type.name)
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(Color(type.name.capitalized))
            .frame(width: size, height: size)
            .scaledToFit()
    }
}


public extension MoveItemDataHolder {
    func Icon(_ size: CGFloat) -> some View {
        Image(type)
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(Color(type.capitalized))
            .frame(width: size, height: size)
            .scaledToFit()
    }
}
