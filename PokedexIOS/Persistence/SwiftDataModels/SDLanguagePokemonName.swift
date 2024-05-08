//
//  @Model.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData


protocol LanguageModel: PersistentModel { }

@Model
public class SDLanguageModel {
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
    
    public init(_ names: [String: String]) {
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
public class SDLanguagePokemonName: LanguageModel {
    
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

    public init(_ names: [String: String]) {
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
public class SDLanguageItemName: LanguageModel {
    
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

    public init(_ names: [String: String]) {
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
