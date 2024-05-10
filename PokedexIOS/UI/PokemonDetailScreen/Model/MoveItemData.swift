//
//  MoveItemData.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 10/05/2024.
//

import Foundation
import DI

public struct MoveItemData: Hashable {
    var querys: PokemonMoveQuery
    var metaVersion: [String : [MoveVersionMeta]]

}
