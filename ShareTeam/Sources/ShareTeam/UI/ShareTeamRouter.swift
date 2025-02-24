//
//  ShareTeamRouter.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/02/2025.
//
import SwiftUI

public protocol ShareTeamRouter {
    var sharingSheet: ShareTeamRoute? { get }
    func back()
    func sharingSheet(_ shareTeamRoute: ShareTeamRoute)
    func closeSharingSheet()
}

@Observable
class ShareTeamRouterAdapterMock: ShareTeamRouter {
    
    public var sharingSheet: ShareTeamRoute?
    
    public func back() { }
    
    public func sharingSheet(_ shareTeamRoute: ShareTeamRoute) { }
    
    public func closeSharingSheet() { }
}
