//
//  class GeneralApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

class GeneralApi<Requested: Decodable>: FetchApiProtocol {
    typealias Query = GeneralQuery
    typealias Requested = Requested
    typealias Failed = ApiPokemonError
    
    struct GeneralQuery: ApiQuery {
        let url: URL
        var urlComponents: URLComponents {
            return .init()
        }
    }
}
