//
//  @Model.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData


public protocol LanguageModel: PersistentModel { }

@Model
public final class SDLanguageModel: LanguageModel, @unchecked Sendable {
    public var japHrkt: String
    public var roomaji: String
    public var ko: String
    public var zhHant: String
    public var fr: String
    public var de: String
    public var es: String
    public var it: String
    @Attribute(.unique) public var en: String
    public var ja: String
    public var zhHans: String
    
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
public final class SDLanguagePokemonName: LanguageModel, @unchecked Sendable {
    
    public var japHrkt: String
    public var roomaji: String
    public var ko: String
    public var zhHant: String
    public var fr: String
    public var de: String
    public var es: String
    public var it: String
    @Attribute(.unique) public var en: String
    public var ja: String
    public var zhHans: String

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
public final class SDLanguageItemName: LanguageModel, @unchecked Sendable {
    
    public var japHrkt: String
    public var roomaji: String
    public var ko: String
    public var zhHant: String
    public var fr: String
    public var de: String
    public var es: String
    public var it: String
    @Attribute(.unique) public var en: String
    public var ja: String
    public var zhHans: String

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

extension Optional: Sendable where Wrapped: Sendable {}
