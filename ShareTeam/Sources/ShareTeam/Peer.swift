//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import MultipeerConnectivity

public struct Peer: Identifiable, Hashable {
    
    public var id: String {
        peerID.displayName
    }
    public let peerID: MCPeerID
}
