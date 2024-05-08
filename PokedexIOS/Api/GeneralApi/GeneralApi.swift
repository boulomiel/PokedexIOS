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
    
    public struct GeneralQuery: ApiQuery {
        let url: URL
        public var urlComponents: URLComponents {
            return .init()
        }
    }
}
