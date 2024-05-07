//
//  @Model.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

//[("ja-Hrkt", "ピカチュウ"), ("roomaji", "Pikachu"), ("ko", "피카츄"), ("zh-Hant", "皮卡丘"), ("fr", "Pikachu"), ("de", "Pikachu"), ("es", "Pikachu"), ("it", "Pikachu"), ("en", "Pikachu"), ("ja", "ピカチュウ"), ("zh-Hans", "皮卡丘")]



protocol LanguageModel: PersistentModel { }

@Model
class SDLanguageModel {
    let japHrkt: String
    let roomaji: String
    let ko: String
    let zhHant: String
    let fr: String
    let de: String
    let es: String
    let it: String
    @Attribute(.unique) let en: String
    let ja: String
    let zhHans: String
    
    init(_ names: [String: String]) {
        japHrkt = names["jap-Hrkt"] ?? ""
        roomaji = names["roomaji"] ?? ""
        ko = names["ko"] ?? ""
        zhHant = names["zh-Hant"] ?? ""
        fr = names["fr"] ?? ""
        de = names["de"] ?? ""
        es = names["es"] ?? ""
        it = names["it"] ?? ""
        en = names["en"] ?? ""
        ja = names["ja"] ?? ""
        zhHans = names["zhHans"] ?? ""
    }
}

@Model
class SDLanguagePokemonName: LanguageModel {
    
    var japHrkt: String
    let roomaji: String
    let ko: String
    let zhHant: String
    let fr: String
    let de: String
    let es: String
    let it: String
    @Attribute(.unique) let en: String
    let ja: String
    let zhHans: String

    init(_ names: [String: String]) {
        japHrkt = names["jap-Hrkt"] ?? ""
        roomaji = names["roomaji"] ?? ""
        ko = names["ko"] ?? ""
        zhHant = names["zh-Hant"] ?? ""
        fr = names["fr"] ?? ""
        de = names["de"] ?? ""
        es = names["es"] ?? ""
        it = names["it"] ?? ""
        en = names["en"] ?? ""
        ja = names["ja"] ?? ""
        zhHans = names["zh-Hans"] ?? ""
    }
}


@Model
class SDLanguageItemName: LanguageModel {
    
    let japHrkt: String
    let roomaji: String
    let ko: String
    let zhHant: String
    let fr: String
    let de: String
    let es: String
    let it: String
    @Attribute(.unique) let en: String
    let ja: String
    let zhHans: String

    init(_ names: [String: String]) {
        japHrkt = names["jap-Hrkt"] ?? ""
        roomaji = names["roomaji"] ?? ""
        ko = names["ko"] ?? ""
        zhHant = names["zh-Hant"] ?? ""
        fr = names["fr"] ?? ""
        de = names["de"] ?? ""
        es = names["es"] ?? ""
        it = names["it"] ?? ""
        en = names["en"] ?? ""
        ja = names["ja"] ?? ""
        zhHans = names["zhHans"] ?? ""
    }
}

enum LanguageName {
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
    
    var english: String {
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
    
    var foreign: String {
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
