//
//  LanguageNameFetcher.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

public struct LanguageNameFetcher {
    
    private let container: ModelContainer
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    func fetchItemNames(for name: String) -> [LanguageName] {
        let name = name.capitalized
        let backgroundHandler = BackgroundDataHander(with: container)
        let result = backgroundHandler.fetch(type: SDLanguageItemName.self, predicate: #Predicate {
            $0.japHrkt.contains(name) ||
            $0.roomaji.contains(name) ||
            $0.ko.contains(name) ||
            $0.zhHant.contains(name) ||
            $0.fr.contains(name) ||
            $0.de.contains(name) ||
            $0.es.contains(name) ||
            $0.it.contains(name) ||
            $0.en.contains(name) ||
            $0.ja.contains(name) ||
            $0.zhHans.contains(name)
        })
        return result.compactMap { LanguageName($0, searchedBy: name) }
    }
    
    func fetchPokemonNames(for name: String) -> [LanguageName] {
        let name = name.capitalized
        let backgroundHandler = BackgroundDataHander(with: container)
        let result = backgroundHandler.fetch(type: SDLanguagePokemonName.self, predicate: #Predicate {
            $0.japHrkt.contains(name) ||
            $0.roomaji.contains(name) ||
            $0.ko.contains(name) ||
            $0.zhHant.contains(name) ||
            $0.fr.contains(name) ||
            $0.de.contains(name) ||
            $0.es.contains(name) ||
            $0.it.contains(name) ||
            $0.en.contains(name) ||
            $0.ja.contains(name) ||
            $0.zhHans.contains(name)
        })
        return result.compactMap { LanguageName($0, searchedBy: name) }
    }
}
