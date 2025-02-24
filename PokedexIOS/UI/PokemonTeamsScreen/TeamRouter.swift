//
//  TeamRouter.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/02/2025.
//
import SwiftUI
import ShareTeam

@Observable
public final class TeamRouter {
    var path: NavigationPath
    var sharingSheet: ShareTeamRoute?
    
    init(path: NavigationPath = .init()) {
        self.path = path
    }
    
    func navigate<Route: Hashable>(to route: Route) {
        path.append(route)
    }
    
    func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func backToRoot() {
        path = .init()
    }
    
    func root<Route: Hashable>(as route: Route) {
        self.path = .init([route])
    }
    
    func sharingSheet(_ shareTeamRoute: ShareTeamRoute) {
        self.sharingSheet = shareTeamRoute
    }
    
    func closeSharingSheet() {
        self.sharingSheet = nil
    }
}
