//
//  ItemCategoryTypeResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

struct ItemCategoryApiResource: Codable, Hashable {
    static func == (lhs: ItemCategoryApiResource, rhs: ItemCategoryApiResource) -> Bool {
        lhs.url == rhs.url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    var name: ItemCategoryType
    var url: URL
}


struct ItemCategories: Codable {
    var count: Int
    var next, previous: URL?
    var results: [ItemCategoryApiResource]
}
