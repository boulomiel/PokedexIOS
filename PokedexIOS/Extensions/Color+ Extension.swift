//
//  Color+ Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let normalType = Color("Normal")
    static let fireType = Color("Fire")
    static let waterType = Color("Water")
    static let electricType = Color("Electric")
    static let grassType = Color("Grass")
    static let iceType = Color("Ice")
    static let fightingType = Color("Fighting")
    static let poisonType = Color("Poison")
    static let groundType = Color("Ground")
    static let flyingType = Color("Flying")
    static let psychicType = Color("Psychic")
    static let bugType = Color("Bug")
    static let rockType = Color("Rock")
    static let ghostType = Color("Ghost")
    static let dragonType = Color("Dragon")
    static let darkType = Color("Dark")
    static let steelType = Color("Steel")
    static let fairyType = Color("Fairy")
    
    public static func makeLinearGradient(for colors: [Color], startPoint: UnitPoint = .leading, endPoint: UnitPoint = .trailing) -> some ShapeStyle {
        LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
    }
    
    public static func makeAngularGradient(for colors: [Color], center: UnitPoint = .center) -> some ShapeStyle {
        AngularGradient(colors: colors, center: center)
    }
    
    public static func makeCircleGradient(for colors: [Color], center: UnitPoint = .center, startRadius: CGFloat = 0, endRadius: CGFloat =  100) -> some ShapeStyle {
        RadialGradient(colors: colors, center: center, startRadius: startRadius, endRadius: endRadius)
    }
}
