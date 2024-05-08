//
//  Preview+Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import Tools
import DI

public extension Preview {
    static var allPreview: Preview {
        Preview(SDTeam.self, SDPokemon.self, SDItem.self, SDMove.self, SDAbility.self, SDSpecies.self, SDLanguagePokemonName.self, SDLanguageItemName.self)
    }
}
