//
//  PokemonStat.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI

struct PokemonDisplayStat: Identifiable, Equatable {
    let id: UUID = .init()
    let name: String
    // api value / 200
    var value: Double
    
    var displayName: String {
        name.replacingOccurrences(of: "-", with: "\n").uppercased()
    }
}

