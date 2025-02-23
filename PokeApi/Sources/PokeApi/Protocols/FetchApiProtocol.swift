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
    
    static func run<T: Decodable & Sendable>(_ session: URLSession, for url: URL, cache: RequestCache = .shared) async -> Result<T, ApiPokemonError> {
        if let cached: T = await cache.get(url: url) {
            return .success(cached)
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        do {
            let (data, response) =  try await session.data(for: request)
            let status = (response as! HTTPURLResponse).statusCode
            if status >= 300 {
                return .failure(.status(description: status))
            }
            do {
                let decoded = try decoder.decode(T.self, from: data)
                await cache.set(url: url, value: decoded)
                return .success(decoded)
            } catch {
                return .failure(.decoding(description: error))
            }
        } catch {
            return .failure(.http(description: error))
        }
    }
}

actor RequestCache {
    
    struct Cached {
        let lastFetched: Date = .now
        let cached: Decodable
    }
    
    var cache: [URL: Cached]
    
    static let shared: RequestCache = .init()
    
    private init(cache:[URL: Cached] = .init()) {
        self.cache = cache
    }
    
    func set(url: URL, value: Decodable) {
        if let current = cache[url],
           let diffs = Calendar.current.dateComponents([.minute], from: current.lastFetched, to: .now).minute,
           diffs >= 5 {
            cache[url] = .init(cached: value)
        }
    }
    
    func get<T: Decodable>(url: URL) -> T? {
        cache[url]?.cached as? T
    }
}
