//
//  NamedAPIResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

// MARK: - Generation
struct NamedAPIResource: Codable, Hashable {
    var name: String
    var url: URL
}
