//
//  MoveBattleStyle.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation

public struct MoveBattleStyle: Codable, Sendable {
    let id: Int
    let name: String
    let names: [Name]
}
