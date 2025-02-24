//
//  ShareTeamRoute.swift
//  ShareTeam
//
//  Created by Ruben Mimoun on 24/02/2025.
//


import Foundation
import SwiftData

public struct ShareTeamRoute: Hashable, Identifiable {
    public var id: PersistentIdentifier {
        return teamID
    }
    public let teamID: PersistentIdentifier
    
    public init(teamID: PersistentIdentifier) {
        self.teamID = teamID
    }
}
