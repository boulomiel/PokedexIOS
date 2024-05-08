//
//  PokemonNameLauncherImpl.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData
import Resources
import Tools

public class PokemonNameLauncherImpl: NameLauncherProtocol {
    
    let apiEnv: PokemonEnvApi
    let api: GeneralApi<ScrollFetchResult>
    let speciesApi: PokemonSpeciesApi
    
    public init(apiEnv: PokemonEnvApi, api: GeneralApi<ScrollFetchResult>, speciesApi: PokemonSpeciesApi) {
        self.apiEnv = apiEnv
        self.api = api
        self.speciesApi = speciesApi
    }
    
    public func getCount() async -> Int {
        guard let url = apiEnv.makeSpeciesURL() else {
            fatalError("\(#function), invalid URL!")
        }
        let result = await api.fetch(query: .init(url: url))
        switch result {
        case .success(let success):
            return success.count
        case .failure(let failure):
            print(#file, #function, failure)
            return 0
        }
    }
    
    public func getAll() async -> [NamedAPIResource] {
        let count = await getCount()
        guard var url = apiEnv.makeSpeciesURL() else {
            fatalError("\(#function), invalid URL!")
        }
        url.append(queryItems: [.init(name: "offset", value: "0"), .init(name: "limit", value: "\(count)")])
        let result = await api.fetch(query: .init(url: url))
        switch result {
        case .success(let success):
            return success.results
        case .failure(let failure):
            print(#file, #function, failure)
            return []
        }
    }
    
    public func get(for name: String) async -> PokemonSpecies? {
        let result = await speciesApi.fetch(query: .init(speciesNumber: name))
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print(#file, #function, failure)
            return nil
        }
    }
    
    public func buildModel(for name: String) async -> SDLanguagePokemonName? {
        let species = await get(for: name)
        guard let species else { return nil }
        let names = species.names.map {
            ($0.language.name, $0.name)
        }
        let dictNames = Dictionary.init(names) { first, second in
            first
        }
        let sdNames = SDLanguagePokemonName(dictNames)
        return sdNames
    }
    
    public func setup(container: ModelContainer) async {
        let pokemons = await getAll()
        await withTaskGroup(of: SDLanguagePokemonName?.self) {group in
            let dataHandler = BackgroundDataHander(with: container)
            pokemons.forEach { named in
                group.addTask { [weak self] in
                   await self?.buildModel(for: named.name)
                }
            }
            for await name in group {
                if let name {
                    dataHandler.insert(name)
                }
            }
            dataHandler.save()
        }
    }
}
