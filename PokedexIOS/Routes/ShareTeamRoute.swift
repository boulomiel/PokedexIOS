//
//  ShareTeamRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import SwiftData

public struct ShareTeamRoute: Hashable, Identifiable {
    public var id: PersistentIdentifier {
        return teamID
    }
    public let teamID: PersistentIdentifier
}
