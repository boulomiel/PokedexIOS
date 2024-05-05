//
//  URLRequest+Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

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
