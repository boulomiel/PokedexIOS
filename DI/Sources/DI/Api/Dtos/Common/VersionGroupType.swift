//
//  VersionGroupType.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

public enum VersionGroupType: String, Codable, CaseIterable, Hashable {
    case redBlue = "red-blue"
    case yellow = "yellow"
    case goldSilver = "gold-silver"
    case crystal = "crystal"
    case rubySaphire = "ruby-sapphire"
    case emerald = "emerald"
    case fireRedLeafGreen = "firered-leafgreen"
    case diamondPearl = "diamond-pearl"
    case platinum = "platinum"
    case heartGoldSoulSilver = "heartgold-soulsilver"
    case blackAndWhite = "black-white"
    case blackAndWhite2 = "black-2-white-2"
    case xY = "x-y"
    case omegaRubyAlphaSaphire = "omega-ruby-alpha-sapphire"
    case UltraSunUltraMoon = "ultra-sun-ultra-moon"
    case swordShield = "sword-shield"
    case letsGo = "lets-go-pikachu-lets-go-eevee"
    case coleseum = "colosseum"
    case xd = "xd"
    case unknown
    
    static var sortedCases: [VersionGroupType] = allCases.sorted(by: { $0.id < $1.id })
    static var relevantCases: [VersionGroupType] = Array(sortedCases[0...sortedCases.count-2])
    
    public var id: Int {
        switch self {
        case .redBlue:
            0
        case .yellow:
            1
        case .goldSilver:
            2
        case .crystal:
            3
        case .rubySaphire:
            4
        case .emerald:
            5
        case .fireRedLeafGreen:
            6
        case .diamondPearl:
            7
        case .platinum:
            8
        case .heartGoldSoulSilver:
            9
        case .blackAndWhite:
            10
        case .blackAndWhite2:
            11
        case .xY:
            12
        case .omegaRubyAlphaSaphire:
            13
        case .UltraSunUltraMoon:
            14
        case .swordShield:
            15
        case .letsGo:
            16
        case .coleseum:
            17
        case .xd:
            18
        case .unknown:
            19
        }
    }
    
    public init?(rawValue: String) {
        if let value = Self.allCases.first(where: { $0.rawValue == rawValue}) {
            self = value
        } else {
            self = .unknown
        }
    }
}


extension Collection where Element == VersionGroupType {
    public func removeUnwanted() -> [Element] {
        return filter { $0 != .xd && $0 != .coleseum && $0 != .unknown }
    }
}
