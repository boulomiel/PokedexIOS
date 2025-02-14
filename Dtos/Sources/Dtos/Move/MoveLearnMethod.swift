//
//  MoveLearnMethod.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveLearnMethod: Codable, Sendable {
    let id: Int
    let name: MoveLearnMethodType
    let descriptions: [Description]
    let names: [Name]
    let version_groups: [NamedAPIResource]
}

