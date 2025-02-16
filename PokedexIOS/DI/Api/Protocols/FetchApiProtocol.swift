//
//  FetchApiProtocol.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public protocol FetchApiProtocol: Sendable {
    associatedtype Query: ApiQuery
    associatedtype Requested: Codable & Sendable
    associatedtype Failed: Error   
}

extension FetchApiProtocol {
    public func fetch(session: URLSession = .shared, query: Query) async  -> Result<Requested, ApiPokemonError> {
        let urlComponents = query.urlComponents
        guard let url = urlComponents.url else {
            fatalError("\(#function), \n \(urlComponents.description), \n could not be url with components")
        }
        return await URLRequest.run(session, for: url)
    }
}

extension FetchApiProtocol where Query == GeneralApi<Requested>.GeneralQuery {
    public func fetch(session: URLSession = .shared, query: Query) async  -> Result<Requested, ApiPokemonError> {
        return await URLRequest.run(session, for: query.url)
    }
}

extension URLRequest {
    static func run<T: Decodable>(_ session: URLSession, for url: URL) async -> Result<T, ApiPokemonError> {
        let request = URLRequest(url: url)
        do {
            let (data, response) =  try await session.data(for: request)
            let status = (response as! HTTPURLResponse).statusCode
            if status >= 300 {
                return .failure(.status(description: status))
            }
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(.decoding(description: error))
            }
        } catch {
            return .failure(.http(description: error))
        }
    }
}
