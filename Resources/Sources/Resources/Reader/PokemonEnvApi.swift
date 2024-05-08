//
//  PokemonEnvApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct PokemonEnvApi: Codable {
    public let scheme: String
    public let host: String
    public let pokemonEndpoint: String
    public let abilityEndpoint: String
    public let speciesEndpoint: String
    public let evolutionChain : String
    public let moveEndpoint: String
    public let machineEndpoint: String
    public let natureEndpoint: String
    public let itemEndpoint: String
    public let categorieItemEndpoint: String
    
    public enum CodingKeys : String, CodingKey {
        case scheme, host,pokemonEndpoint, abilityEndpoint, speciesEndpoint, moveEndpoint, machineEndpoint, natureEndpoint, itemEndpoint, categorieItemEndpoint
        case evolutionChain = "evolution-chain"
    }
    
    public var urlComponents: URLComponents {
        let api: PokemonEnvApi = PlistReader.read(list: .pokemonapi)
        var components = URLComponents()
        components.host = api.host
        components.scheme = api.scheme
        return components
    }
    
    public func makeItemURL() -> URL? {
        var c = urlComponents
        c.path = categorieItemEndpoint
        return c.url
    }
    
    public func makeSpeciesURL() -> URL? {
        var c = urlComponents
        c.path = speciesEndpoint
        return c.url
    }
}
