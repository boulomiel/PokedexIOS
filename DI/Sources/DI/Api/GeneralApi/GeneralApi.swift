//
// public class GeneralApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

public class GeneralApi<Requested: Decodable>: FetchApiProtocol {
    public typealias Query = GeneralQuery
    public typealias Requested = Requested
    public typealias Failed = ApiPokemonError
    
    public init() {}
    
    public struct GeneralQuery: ApiQuery {
        let url: URL
        
        public init(url: URL) {
            self.url = url
        }
        
        public var urlComponents: URLComponents {
            return .init()
        }
    }
}
