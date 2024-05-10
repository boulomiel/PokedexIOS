//
//  GridCellPokemonSelectionEventBound.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 10/05/2024.
//

import Foundation
import Combine
import Dtos

public final class GridCellPokemonSelectionEventBound {
    public enum EventBound {
        case showSelection(Bool)
        case selectedPokemon(pokemons: [Pokemon])
        case showVarietiesForCell(local: LocalPokemon?)
    }
    
    public let event: PassthroughSubject<EventBound, Never>
    
    public init(event: PassthroughSubject<EventBound, Never> = .init()) {
        self.event = event
    }
}
