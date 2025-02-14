//
//  MoveMethodApiResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

public struct MoveMethodApiResource: Codable, Sendable {
    let name: MoveLearnMethodType
    let url: URL
}
