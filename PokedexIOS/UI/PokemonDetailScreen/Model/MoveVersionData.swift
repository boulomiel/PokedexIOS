//
//  MoveVersionData.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 10/05/2024.
//

import Foundation
import Dtos

public struct MoveVersionMeta: Hashable {
    var moveName: String
    var version: VersionGroupType
    var levelLearntAt: Int
    var learningMethod: MoveLearnMethodType
}
