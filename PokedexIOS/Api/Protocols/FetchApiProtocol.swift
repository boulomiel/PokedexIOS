//
//  FetchApiProtocol.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public protocol FetchApiProtocol {
   associatedtype Query: ApiQuery
   associatedtype Requested: Decodable
   associatedtype Failed: Error   
}

extension FetchApiProtocol {
    func fetch(session: URLSession = .shared, query: Query) async  -> Result<Requested, ApiPokemonError> {
        let urlComponents = query.urlComponents
        guard let url = urlComponents.url else {
            fatalError("\(#function), \n \(urlComponents.description), \n could not be url with components")
        }
        return await URLRequest.run(session, for: url)
    }
}

extension FetchApiProtocol where Query == GeneralApi<Requested>.GeneralQuery {
    func fetch(session: URLSession = .shared, query: Query) async  -> Result<Requested, ApiPokemonError> {
        return await URLRequest.run(session, for: query.url)
    }
}
