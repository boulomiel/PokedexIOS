//
//  SDTeam+Extensions.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import DI

public extension SDTeam {
    static var examples: [SDTeam] {
        [
            .init(name: "DreamTeam"),
            .init(name: "LooserTeam"),
            .init(name: "MyFavorites"),
            .init(name: "WaterSwimmer")
        ]
    }
}
