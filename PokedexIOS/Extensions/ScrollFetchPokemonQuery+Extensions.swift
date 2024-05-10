//
//  ScrollFetchPokemonQuery+Extensions.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import DI

public extension ScrollFetchPokemonQuery {
    func next() -> Self {
        .init(limit: limit, offset: offset + 50)
    }
}
