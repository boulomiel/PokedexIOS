//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 08/05/2024.
//

import Foundation
import SwiftData

public protocol SDDataDecoder {
    associatedtype Decoded: Codable & Sendable
    var data: Data? { get }
}

public extension SDDataDecoder {
     var decoded: Decoded? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Decoded.self, from: data)
    }
    
    func decodedAsync() async -> Decoded? {
        guard let data = data else { return nil }
        let decoded = Task {
            let decoder = JSONDecoder()
            return try? decoder.decode(Decoded.self, from: data)
        }
        return await decoded.value
    }
}

