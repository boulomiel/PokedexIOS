//
//  FetchPokemonError.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

public enum ApiPokemonError: ApiError, LocalizedError, Sendable {
    case http(description: Error)
    case status(description: Int)
    case decoding(description: Error)
}
