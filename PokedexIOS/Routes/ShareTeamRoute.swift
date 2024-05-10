//
//  ShareTeamRoute.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import SwiftData

struct ShareTeamRoute: Hashable, Identifiable {
    var id: PersistentIdentifier {
        return teamID
    }
    let teamID: PersistentIdentifier
}
