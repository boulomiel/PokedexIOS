//
//  ItemCategoryTypeResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

public struct ItemCategoryApiResource: Codable, Hashable, Sendable {
    public static func == (lhs: ItemCategoryApiResource, rhs: ItemCategoryApiResource) -> Bool {
        lhs.url == rhs.url
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    public let name: ItemCategoryType
    public let url: URL
}


public struct ItemCategories: Codable, Sendable {
    public let count: Int
    public let next, previous: URL?
    public let results: [ItemCategoryApiResource]
}
