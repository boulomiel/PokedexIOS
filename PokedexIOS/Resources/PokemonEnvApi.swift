//
//  PokemonEnvApi.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import Foundation

struct PokemonEnvApi: Codable {
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
    
    enum CodingKeys : String, CodingKey {
        case scheme, host,pokemonEndpoint, abilityEndpoint, speciesEndpoint, moveEndpoint, machineEndpoint, natureEndpoint, itemEndpoint, categorieItemEndpoint
        case evolutionChain = "evolution-chain"
    }
}
