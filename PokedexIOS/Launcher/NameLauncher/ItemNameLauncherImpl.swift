//
//  ItemNameLauncherImpl.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

public class ItemNameLauncherImpl: NameLauncherProtocol {
    
    let apiEnv: PokemonEnvApi
    let api: GeneralApi<ScrollFetchResult>
    let itemApi: PokemonItemApi

    public init(apiEnv: PokemonEnvApi, api: GeneralApi<ScrollFetchResult>, itemApi: PokemonItemApi) {
        self.apiEnv = apiEnv
        self.api = api
        self.itemApi = itemApi
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
    
    public func get(for name: String) async -> Item? {
        let result = await itemApi.fetch(query: .init(itemID: name))
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            print(#file, #function, failure, name)
            return nil
        }
    }
    
    public func buildModel(for name: String) async -> SDLanguageItemName? {
        let species = await get(for: name)
        guard let species else { return nil }
        let names = species.names.map {
            ($0.language.name, $0.name)
        }
        let dictNames = Dictionary.init(names) { first, second in
            first
        }
        let sdNames = SDLanguageItemName(dictNames)
        return sdNames
    }
    
    public func setup(container: ModelContainer) async {
        let items = await getAll()
        await withTaskGroup(of: SDLanguageItemName?.self) {group in
            let dataHandler = BackgroundDataHander(with: container)
            items.forEach { item in
                group.addTask { [weak self] in
                    await self?.buildModel(for: item.url.lastPathComponent)
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
