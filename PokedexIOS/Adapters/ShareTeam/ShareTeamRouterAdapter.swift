//
//  ShareTeamRouterImpl.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/02/2025.
//
import SwiftUI
import ShareTeam

@Observable
public class ShareTeamRouterAdapter: ShareTeamRouter {
    
    public var sharingSheet: ShareTeamRoute?
    private let router: TeamRouter
    
    init(router: TeamRouter) {
        self.router = router
    }
    
    public func back() {
        router.back()
    }
    
    public func sharingSheet(_ shareTeamRoute: ShareTeamRoute) {
        router.sharingSheet(shareTeamRoute)
    }
    
    public func closeSharingSheet() {
        router.closeSharingSheet()
    }
}
