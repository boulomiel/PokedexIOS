//
//  PokemonType + Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import DI
import SwiftUI
import Dtos

extension PokemonType {
    
    var pokemonType: PT? {
        return .init(typeString: type.name.capitalized)
    }
    
    enum PT: String {
        case normal
        case fire
        case water
        case electric
        case grass
        case ice
        case fighting
        case poison
        case ground
        case flying
        case psychic
        case bug
        case rock
        case ghost
        case dragon
        case dark
        case steel
        case fairy
        
        init?(typeString: String) {
            // Convert the type string to lowercase to handle case insensitivity
            let lowercaseTypeString = typeString.lowercased()
            switch lowercaseTypeString {
            case "normal": self = .normal
            case "fire": self = .fire
            case "water": self = .water
            case "electric": self = .electric
            case "grass": self = .grass
            case "ice": self = .ice
            case "fighting": self = .fighting
            case "poison": self = .poison
            case "ground": self = .ground
            case "flying": self = .flying
            case "psychic": self = .psychic
            case "bug": self = .bug
            case "rock": self = .rock
            case "ghost": self = .ghost
            case "dragon": self = .dragon
            case "dark": self = .dark
            case "steel": self = .steel
            case "fairy": self = .fairy
            default:
                // If the string does not match any type, return nil
                print("Unknown", typeString)
                return nil
            }
        }
        
        var color: Color {
             Color(self.rawValue.capitalized)
        }
        
        var gradient: AnyGradient {
             Color(self.rawValue.capitalized).gradient
        }
        
        var image: Image {
            Image(self.rawValue)
        }
        
    }
}

extension Array where Element == PokemonType {
    
    var pt: [PokemonType.PT] {
        self.compactMap { $0.pokemonType }
    }
}

extension Array where Element == PokemonType.PT {
    
    var horizontalLinearGradient: some ShapeStyle {
        Color.makeLinearGradient(for: map(\.color), startPoint: .leading, endPoint: .trailing)
    }
    
    var verticalLinearGradient: some ShapeStyle {
        Color.makeLinearGradient(for: map(\.color), startPoint: .top, endPoint: .bottom)
    }
    
    var circleGradient: some ShapeStyle {
        Color.makeCircleGradient(for: map(\.color))
    }
    
    func circleGradient(startRadius: CGFloat, endRadius: CGFloat) -> some ShapeStyle {
        Color.makeCircleGradient(for: map(\.color), startRadius: startRadius, endRadius: endRadius)
    }
}
