//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import MultipeerConnectivity

public enum ShareSessionEvent {
    case receivedInvite(from: MCPeerID)
    case isPaired(isPaired: Bool)
    case receivedData(data: Data)
    case sent
}
