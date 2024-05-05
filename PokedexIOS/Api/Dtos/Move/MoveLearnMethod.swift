//
//  MoveLearnMethod.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

struct MoveLearnMethod: Codable {
    var id: Int
    var name: MoveLearnMethodType
    var descriptions: [Description]
    var names: [Name]
    var version_groups: [NamedAPIResource]
}

