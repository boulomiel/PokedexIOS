//
//  NamedAPIResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

// MARK: - Generation
public struct NamedAPIResource: Codable, Hashable {
    public let name: String
    public let url: URL
    
    public init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
