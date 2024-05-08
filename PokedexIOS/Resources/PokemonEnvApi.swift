//
//  PokemonEnvApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

public struct PokemonEnvApi: Codable {
    let scheme: String
    let host: String
    let pokemonEndpoint: String
    let abilityEndpoint: String
    let speciesEndpoint: String
    let evolutionChain : String
    let moveEndpoint: String
    let machineEndpoint: String
    let natureEndpoint: String
    let itemEndpoint: String
    let categorieItemEndpoint: String
    
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
