//
//  NetworkManager.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 03/05/2024.
//

import Foundation
import Network

@Observable
public final class NetworkManager: Sendable {
    
    enum Status {
        case idle, connected, deconnected
        
        var showContent: Bool {
            switch self {
            case .idle:
                fallthrough
            case .connected:
                return true
            case .deconnected:
                return false
            }
        }
    }
    
    let monitor: NWPathMonitor
    let queue: DispatchQueue
    nonisolated(unsafe) private(set) var status: Status
    nonisolated(unsafe) private(set) var isConnected: Bool
    
    public var showContent: Bool {
        status.showContent
    }
    
    public init(monitor: NWPathMonitor = .init(), queue: DispatchQueue = .init(label: "com.networkmanager", qos: .background)) {
        self.monitor = monitor
        self.queue = queue
        self.isConnected = false
        self.status = .idle
        startMonitoring()
    }
    
    private func startMonitoring() {
        self.monitor.start(queue: queue)
        self.monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {[weak self] in
                guard let self else { return }
                if path.status == .satisfied {
                    status = .connected
                } else {
                    status = .deconnected
                }
            }
        }
    }
    
    public func stopMonitoring() {
        self.monitor.cancel()
    }
}
