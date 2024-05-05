//
//  MoveItemDataHolder.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation

struct MoveItemDataHolder: Hashable, Identifiable {
    var id: Int
    var name: [MoveNameItem] //language: name
    let effects: [MoveEffectItem] //language: effect description
    var type: String
    var damageClass: MoveDamageType
    var generation: String
    var drain: Int?
    var healing: Int?
    var critRate: Int?
    var ailmentChance: Int?
    var flintChance: Int?
    var statChance: Int?
    var learntBy: [String] //pokemon names
    var priority: Int
    var pp: Int
    var power: Int?
}
