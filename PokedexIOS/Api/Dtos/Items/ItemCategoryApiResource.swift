//
//  ItemCategoryTypeResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

public struct ItemCategoryApiResource: Codable, Hashable {
    public static func == (lhs: ItemCategoryApiResource, rhs: ItemCategoryApiResource) -> Bool {
        lhs.url == rhs.url
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    var name: ItemCategoryType
    var url: URL
}


public struct ItemCategories: Codable {
    var count: Int
    var next, previous: URL?
    var results: [ItemCategoryApiResource]
}
