//
//  LanguageNameFetcher.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 08/05/2024.
//
import Foundation
import SwiftData
import Tools

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

public enum LanguageName {
    case japHrkt(englishName: String, name: String)
    case roomaji(englishName: String, name: String)
    case ko(englishName: String, name: String)
    case zhHant(englishName: String, name: String)
    case fr(englishName: String, name: String)
    case de(englishName: String, name: String)
    case es(englishName: String, name: String)
    case it(englishName: String, name: String)
    case en(englishName: String)
    case ja(englishName: String, name: String)
    case zhHans(englishName: String, name: String)
    
    public var english: String {
        switch self {
        case .japHrkt(let englishName, _):
            fallthrough
        case .roomaji(let englishName, _):
            fallthrough
        case .ko(let englishName, _):
            fallthrough
        case .zhHant(let englishName, _):
            fallthrough
        case .fr(let englishName, _):
            fallthrough
        case .de(let englishName, _):
            fallthrough
        case .es(let englishName, _):
            fallthrough
        case .it(let englishName, _):
            fallthrough
        case .ja(let englishName, _):
            fallthrough
        case .zhHans(let englishName, _):
            fallthrough
        case .en(let englishName):
            return englishName.lowercased()
        }
    }
    
    public var foreign: String {
        switch self {
        case .en(let englishName):
            return englishName
        case .japHrkt(_, let name):
            fallthrough
        case .roomaji(_, let name):
            fallthrough
        case .ko(_, let name):
            fallthrough
        case .zhHant(_, let name):
            fallthrough
        case .fr(_, let name):
            fallthrough
        case .de(_, let name):
            fallthrough
        case .es(_, let name):
            fallthrough
        case .it(_, let name):
            fallthrough
        case .ja(_, let name):
            fallthrough
        case .zhHans(_, let name):
            return name
        }
    }
    
    var language: String {
        switch self {
        case .en:
            return "en"
        case .japHrkt:
            return "jap-Hrkt"
        case .roomaji:
            return "roomaji"
        case .ko:
            return "ko"
        case .zhHant:
            return "zhHant"
        case .fr:
            return "fr"
        case .de:
            return "de"
        case .es:
            return "es"
        case .it:
            return "it"
        case .ja:
            return "ja"
        case .zhHans:
            return "zh-Hans"
        }
    }
}
