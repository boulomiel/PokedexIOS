//
//  ScrollFetchQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import Dtos

public struct ScrollFetchResult: Codable, Sendable {
    public var count: Int
    let next, previous: URL?
    public var results: [NamedAPIResource]
}

