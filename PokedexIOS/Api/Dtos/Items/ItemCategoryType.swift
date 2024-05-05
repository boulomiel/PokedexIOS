//
//  ItemCategoryType.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

enum ItemCategoryType: Codable {
    case statBoosts
    case effortDrop
    case medicine
    case other
    case inAPinch
    case pickyHealing
    case typeProtection
    case bakingOnly
    case collectibles
    case evolution
    case spelunking
    case heldItems
    case choice
    case effortTraining
    case badHeldItems
    case training
    case plates
    case speciesSpecific
    case typeEnhancement
    case eventItems
    case gameplay
    case plotAdvancement
    case unused
    case loot
    case allMail
    case vitamins
    case healing
    case ppRecovery
    case revival
    case statusCures
    case mulch
    case specialBalls
    case standardBalls
    case dexCompletion
    case scarves
    case allMachines
    case flutes
    case apricornBalls
    case apricornBox
    case dataCards
    case jewels
    case miracleShooter
    case megaStones
    case memories
    case zCrystals
    case speciesCandies
    case catchingBonus
    case dynamaxCrystals
    case natureMints
    case curryIngredients
    case teraShard
    case sandwichIngredients
    case tmMaterials
    case picnic
    case unknown(String)
    
    func getName() -> String {
        switch self {
        case .statBoosts:
            return "stat-boosts"
        case .effortDrop:
            return "effort-drop"
        case .medicine:
            return "medicine"
        case .other:
            return "other"
        case .inAPinch:
            return "in-a-pinch"
        case .pickyHealing:
            return "picky-healing"
        case .typeProtection:
            return "type-protection"
        case .bakingOnly:
            return "baking-only"
        case .collectibles:
            return "collectibles"
        case .evolution:
            return "evolution"
        case .spelunking:
            return "spelunking"
        case .heldItems:
            return "held-items"
        case .choice:
            return "choice"
        case .effortTraining:
            return "effort-training"
        case .badHeldItems:
            return "bad-held-items"
        case .training:
            return "training"
        case .plates:
            return "plates"
        case .speciesSpecific:
            return "species-specific"
        case .typeEnhancement:
            return "type-enhancement"
        case .eventItems:
            return "event-items"
        case .gameplay:
            return "gameplay"
        case .plotAdvancement:
            return "plot-advancement"
        case .unused:
            return "unused"
        case .loot:
            return "loot"
        case .allMail:
            return "all-mail"
        case .vitamins:
            return "vitamins"
        case .healing:
            return "healing"
        case .ppRecovery:
            return "pp-recovery"
        case .revival:
            return "revival"
        case .statusCures:
            return "status-cures"
        case .mulch:
            return "mulch"
        case .specialBalls:
            return "special-balls"
        case .standardBalls:
            return "standard-balls"
        case .dexCompletion:
            return "dex-completion"
        case .scarves:
            return "scarves"
        case .allMachines:
            return "all-machines"
        case .flutes:
            return "flutes"
        case .apricornBalls:
            return "apricorn-balls"
        case .apricornBox:
            return "apricorn-box"
        case .dataCards:
            return "data-cards"
        case .jewels:
            return "jewels"
        case .miracleShooter:
            return "miracle-shooter"
        case .megaStones:
            return "mega-stones"
        case .memories:
            return "memories"
        case .zCrystals:
            return "z-crystals"
        case .speciesCandies:
            return "species-candies"
        case .catchingBonus:
            return "catching-bonus"
        case .dynamaxCrystals:
            return "dynamax-crystals"
        case .natureMints:
            return "nature-mints"
        case .curryIngredients:
            return "curry-ingredients"
        case .teraShard:
            return "tera-shard"
        case .sandwichIngredients:
            return "sandwich-ingredients"
        case .tmMaterials:
            return "tm-materials"
        case .picnic:
            return "picnic"
        case .unknown(let name):
            return name
        }
    }
}

extension ItemCategoryType {
    init(stringValue: String) {
        self = getItemCategory(from: stringValue)
    }
    
    init(from decoder: any Decoder) throws {
        let name = try decoder.singleValueContainer().decode(String.self)
        self = getItemCategory(from: name)
    }
}


fileprivate  func getItemCategory(from name: String) -> ItemCategoryType {
    switch name {
    case "stat-boosts":
        return .statBoosts
    case "effort-drop":
        return .effortDrop
    case "medicine":
        return .medicine
    case "other":
        return .other
    case "in-a-pinch":
        return .inAPinch
    case "picky-healing":
        return .pickyHealing
    case "type-protection":
        return .typeProtection
    case "baking-only":
        return .bakingOnly
    case "collectibles":
        return .collectibles
    case "evolution":
        return .evolution
    case "spelunking":
        return .spelunking
    case "held-items":
        return .heldItems
    case "choice":
        return .choice
    case "effort-training":
        return .effortTraining
    case "bad-held-items":
        return .badHeldItems
    case "training":
        return .training
    case "plates":
        return .plates
    case "species-specific":
        return .speciesSpecific
    case "type-enhancement":
        return .typeEnhancement
    case "event-items":
        return .eventItems
    case "gameplay":
        return .gameplay
    case "plot-advancement":
        return .plotAdvancement
    case "unused":
        return .unused
    case "loot":
        return .loot
    case "all-mail":
        return .allMail
    case "vitamins":
        return .vitamins
    case "healing":
        return .healing
    case "pp-recovery":
        return .ppRecovery
    case "revival":
        return .revival
    case "status-cures":
        return .statusCures
    case "mulch":
        return .mulch
    case "special-balls":
        return .specialBalls
    case "standard-balls":
        return .standardBalls
    case "dex-completion":
        return .dexCompletion
    case "scarves":
        return .scarves
    case "all-machines":
        return .allMachines
    case "flutes":
        return .flutes
    case "apricorn-balls":
        return .apricornBalls
    case "apricorn-box":
        return .apricornBox
    case "data-cards":
        return .dataCards
    case "jewels":
        return .jewels
    case "miracle-shooter":
        return .miracleShooter
    case "mega-stones":
        return .megaStones
    case "memories":
        return .memories
    case "z-crystals":
        return .zCrystals
    case "species-candies":
        return .speciesCandies
    case "catching-bonus":
        return .catchingBonus
    case "dynamax-crystals":
        return .dynamaxCrystals
    case "nature-mints":
        return .natureMints
    case "curry-ingredients":
        return .curryIngredients
    case "tera-shard":
        return .teraShard
    case "sandwich-ingredients":
        return .sandwichIngredients
    case "tm-materials":
        return .tmMaterials
    case "picnic":
        return .picnic
    default:
        return .unknown(name)
    }
}

