//
//  DescriptionByVersionModel.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import Foundation

public struct DescriptionByVersionModel: Identifiable, Hashable {
    public let id: UUID = .init()
    var version: String
    var description: String
    var language: String
    
    var array: [String] {
        description.replacingOccurrences(of: "\n", with: " ").trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
    }
    
    var readableDescription: String {
        return description.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: " ")
    }
    
    var readableVersion: String {
        version.replacingOccurrences(of: "-", with: " ").capitalized
    }
}
