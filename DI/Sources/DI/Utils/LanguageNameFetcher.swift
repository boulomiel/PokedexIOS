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
    
    public init(container: ModelContainer) {
        self.container = container
    }
    
    public func fetchItemNames(for name: String) -> [LanguageName] {
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
    
    public func fetchPokemonNames(for name: String) -> [LanguageName] {
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
    
    public var language: String {
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

public extension LanguageName {
    init(_ model: SDLanguageItemName, searchedBy input: String) {
        if model.japHrkt.contains(input) {
            self = .japHrkt(englishName: model.en, name: model.japHrkt)
        } else
        if model.roomaji.contains(input) {
            self = .roomaji(englishName: model.en, name: model.roomaji)
        } else
        if model.ko.contains(input) {
            self = .ko(englishName: model.en, name: model.ko)
        } else
        if model.zhHant.contains(input) {
            self = .zhHant(englishName: model.en, name: model.zhHant)
        } else
        if model.fr.contains(input) {
            self = .fr(englishName: model.en, name: model.fr)
        } else
        if model.de.contains(input) {
            self = .de(englishName: model.en, name: model.de)
        } else
        if model.es.contains(input){
            self = .es(englishName: model.en, name: model.es)
        } else
        if model.it.contains(input) {
            self = .it(englishName: model.en, name: model.it)
        } else
        if model.en.contains(input) {
            self = .en(englishName: model.en)
        } else
        if model.ja.contains(input) {
            self = .ja(englishName: model.en, name: model.ja)
        } else
        if model.zhHans.contains(input) {
            self = .zhHans(englishName: model.en, name: model.zhHans)
        } else {
            self = .en(englishName: model.en)
        }
    }
    
    init(_ model: SDLanguagePokemonName, searchedBy input: String) {
        if model.japHrkt.contains(input) {
            self = .japHrkt(englishName: model.en, name: model.japHrkt)
        } else
        if model.roomaji.contains(input) {
            self = .roomaji(englishName: model.en, name: model.roomaji)
        } else
        if model.ko.contains(input) {
            self = .ko(englishName: model.en, name: model.ko)
        } else
        if model.zhHant.contains(input) {
            self = .zhHant(englishName: model.en, name: model.zhHant)
        } else
        if model.fr.contains(input) {
            self = .fr(englishName: model.en, name: model.fr)
        } else
        if model.de.contains(input) {
            self = .de(englishName: model.en, name: model.de)
        } else
        if model.es.contains(input){
            self = .es(englishName: model.en, name: model.es)
        } else
        if model.it.contains(input) {
            self = .it(englishName: model.en, name: model.it)
        } else
        if model.en.contains(input) {
            self = .en(englishName: model.en)
        } else
        if model.ja.contains(input) {
            self = .ja(englishName: model.en, name: model.ja)
        } else
        if model.zhHans.contains(input) {
            self = .zhHans(englishName: model.en, name: model.zhHans)
        } else {
            self = .en(englishName: model.en)
        }
    }
}

