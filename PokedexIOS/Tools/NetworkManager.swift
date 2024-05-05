//
//  NetworkManager.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 03/05/2024.
//

import Foundation
import Network

@Observable
class NetworkManager {
    
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
    private (set) var status: Status
    private (set) var isConnected: Bool
    
    init(monitor: NWPathMonitor = .init(), queue: DispatchQueue = .init(label: "com.networkmanager", qos: .background)) {
        self.monitor = monitor
        self.queue = queue
        self.isConnected = false
        self.status = .idle
        startMonitoring()
    }
    
    private func startMonitoring() {
        self.monitor.start(queue: queue)
        self.monitor.pathUpdateHandler = {[weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.status = .connected
                } else {
                    self?.status = .deconnected
                }
            }
        }
    }
    
    func stopMonitoring() {
        self.monitor.cancel()
    }
}
