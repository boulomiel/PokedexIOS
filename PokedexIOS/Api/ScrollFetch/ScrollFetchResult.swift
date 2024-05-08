//
//  ScrollFetchQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public struct ScrollFetchResult: Codable {
    var count: Int
    var next, previous: URL?
    var results: [NamedAPIResource]
}

