//
//  View + Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import SwiftUI
import DI

extension View {
    @ViewBuilder
    func wrappedInScroll(_ isWrapped: Bool, axis: Axis.Set) -> some View {
        if isWrapped {
            ScrollView(axis) {
                self
            }
        } else {
            self
        }
    }
    
    @ViewBuilder
    func pokemonTypeBackgroundH(types: [PokemonType.PT]) -> some View {
        if types.isEmpty {
            self
        } else {
            if types.count > 1 {
                self
                    .background(types.horizontalLinearGradient)
            } else {
                self
                    .background(types[0].gradient)
            }
        }
    }
    
    @ViewBuilder
    func pokemonTypeBackgroundV(types: [PokemonType.PT]) -> some View {
        if types.isEmpty {
            self
        } else {
            if types.count > 1 {
                self
                    .background(types.verticalLinearGradient)
            } else {
                self
                    .background(types[0].gradient)
            }
        }
    }
    
    @ViewBuilder
    func pokemonTypeBackgroundCircle(types: [PokemonType.PT]) -> some View {
        if types.isEmpty {
            self
        } else {
            if types.count > 1 {
                self
                    .background(types.circleGradient)
            } else {
                self
                    .background(types[0].gradient)
            }
        }
    }
}
