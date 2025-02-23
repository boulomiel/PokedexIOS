//
//  MoveItemData.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 10/05/2024.
//

import Foundation
import PokeApi

public struct MoveItemData: Hashable {
    var querys: PokemonMoveQuery
    var metaVersion: [String : [MoveVersionMeta]]

}
