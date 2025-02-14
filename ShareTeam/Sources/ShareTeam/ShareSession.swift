//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 09/05/2024.
//

@preconcurrency import MultipeerConnectivity
import os
@preconcurrency import Combine

@Observable
public final class ShareSession: NSObject, Sendable {
    private let serviceType = "rps-service"
    nonisolated(unsafe) private var myPeerID: Peer?
    
    nonisolated(unsafe) private var serviceAdvertiser: MCNearbyServiceAdvertiser?
    nonisolated(unsafe) private var serviceBrowser: MCNearbyServiceBrowser?
    nonisolated(unsafe) private var session: MCSession?
    
    nonisolated(unsafe) private var availablePeers: Set<Peer> = .init()
    nonisolated(unsafe) public var peers: [Peer] {
        availablePeers.sorted(by: { $0.id < $1.id })
    }
    public let event: PassthroughSubject<ShareSessionEvent, Never>
    nonisolated(unsafe) private var invitationHandler: ((Bool, MCSession?) -> Void)?
    nonisolated(unsafe) private var onInviteAccepted: (() -> Void)?
    
    public override init() {
        event = .init()
        super.init()
    }
    
    deinit {
        finish()
    }
    
    @MainActor
    public func start(as username: String, shouldOpenSetting: (()->Void)? = nil) {
        let peerID = MCPeerID(displayName: username)
        let state = LocalNetworkAuthorization()
        state.requestAuthorization {[weak self] isGranted in
            guard let self else { return }
            if isGranted {
                setup(displayName: username)
            } else {
                DispatchQueue.main.async {
                    shouldOpenSetting?()
                }
            }
        }
    }
    
    public func send(data: Data?) {
        guard let session, let data else { return }
        if !session.connectedPeers.isEmpty {
            print(#file, #function)
            do {
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                print(#file, #function, error)
            }
        }
    }
    
    public func invite(_ peer: Peer, sharedTeam: SharedTeam) {
        guard let session else { return }
        let state = LocalNetworkAuthorization()
        onInviteAccepted = { [weak self] in self?.send(data: try? JSONEncoder().encode(sharedTeam)) }
        serviceBrowser?.invitePeer(peer.peerID, to: session, withContext: nil, timeout: 30)
    }
    
    public func answerInvitation(isAccepted: Bool) {
        guard let session else { return }
        if !isAccepted {
            onInviteAccepted = nil
        }
        invitationHandler?(isAccepted, session)
    }
    
    public func finish() {
        serviceAdvertiser?.stopAdvertisingPeer()
        serviceBrowser?.stopBrowsingForPeers()
    }
    
    private func setup(displayName: String) {
        let peerID = MCPeerID(displayName: displayName)
        myPeerID = .init(peerID: peerID)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        session?.delegate = self
        serviceAdvertiser?.delegate = self
        serviceBrowser?.delegate = self
        serviceAdvertiser?.startAdvertisingPeer()
        serviceBrowser?.startBrowsingForPeers()
    }
}

extension ShareSession: MCNearbyServiceAdvertiserDelegate {
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        //TODO: Inform the user something went wrong and try again
        print(#file, #function, error)
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print(#file, #function, peerID)
        self.invitationHandler = invitationHandler
        DispatchQueue.main.async {
            self.event.send(.receivedInvite(from: peerID))
            // Give PairView the `invitationHandler` so it can accept/deny the invitation
        }
    }
}

extension ShareSession: MCNearbyServiceBrowserDelegate {
    public func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        //TODO: Tell the user something went wrong and try again
        print(#file, #function, error)
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print(#file, #function, peerID)
        guard peerID.displayName != myPeerID?.id else { return }
        // Add the peer to the list of available peers
        DispatchQueue.main.async {
            self.availablePeers.insert(.init(peerID: peerID))
        }
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print(#file, #function, peerID)
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.remove(.init(peerID: peerID))
        }
    }
}

extension ShareSession: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print(#file, #function, peerID, state.rawValue)

        switch state {
        case MCSessionState.notConnected:
            DispatchQueue.main.async {[weak self] in
                self?.event.send(.isPaired(isPaired: false))
            }
            serviceAdvertiser?.startAdvertisingPeer()
            break
        case MCSessionState.connected:
            DispatchQueue.main.async {[weak self] in
                self?.event.send(.isPaired(isPaired: true))
                self?.onInviteAccepted?()
                self?.event.send(.sent)
            }
            serviceAdvertiser?.stopAdvertisingPeer()
            break
        default:
            DispatchQueue.main.async { [weak self] in
                self?.event.send(.isPaired(isPaired: false))
            }
            break
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.event.send(.receivedData(data: data))
        }
        print(#function, #file)
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print(#file, #function, peerID, "Receiving streams is not supported")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(#file, #function, peerID, "Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print(#file, #function, peerID, "Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}

