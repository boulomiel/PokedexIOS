//
//  MoveDamageType.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation
import SwiftUI

enum MoveDamageType: String {
    case physical, status, special
    
    init!(rawValue: String) {
        switch rawValue {
        case Self.physical.rawValue:
            self = .physical
        case Self.special.rawValue:
            self = .special
        case Self.status.rawValue:
            self = .status
        default:
            fatalError("Unknowed type \(rawValue)")
        }
    }
    
//    @ViewBuilder
//    var view: some View {
//        switch self {
//        case .physical:
//            PhysicalMoveView()
//        case .status:
//            StatusMoveView()
//        case .special:
//            SpecialMoveView()
//        }
//    }
    
    func image(width: CGFloat, height: CGFloat) -> some View {
        Image(self.rawValue)
            .resizable()
            .frame(width: width, height: height)
            .scaledToFit()
    }
}
