//
//  MoveLearnMethodType.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

enum MoveLearnMethodType: String, Codable , CaseIterable, Hashable{
    case levelUp = "level-up", egg, tutor, machine
    case stadiumSurphingPikachu = "stadium-surfing-pikachu"
    case lightBallEgg = "light-ball-egg"
    case colosseumPurification = "colosseum-purification"
    case xdShadow = "xd-shadow"
    case xdPurification = "xd-purification"
    case formChange = "form-change"
    case zygardeCube = "zygarde-cube"
    case unknown 
    
    init?(rawValue: String) {
        if let value = Self.allCases.first(where: { $0.rawValue == rawValue}) {
            self = value
        } else {
            self = .unknown
        }
    }
    
    var id: Int {
        switch self {
        case .levelUp:
            0
        case .machine:
            1
        case .egg:
            3
        case .tutor:
            4
        case .stadiumSurphingPikachu:
            5
        case .lightBallEgg:
            6
        case .colosseumPurification:
            7
        case .xdShadow:
            8
        case .xdPurification:
            9
        case .formChange:
            10
        case .zygardeCube:
            11
        case .unknown:
            12
        }
    }
}
