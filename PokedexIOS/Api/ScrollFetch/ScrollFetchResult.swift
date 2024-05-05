//
//  ScrollFetchQuery.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

struct ScrollFetchResult: Codable {
    var count: Int
    var next, previous: URL?
    var results: [ScrolledFetchedElement]
}

// MARK: - Result
struct ScrolledFetchedElement: Codable, Hashable {
    var name: String
    var url: URL
}
