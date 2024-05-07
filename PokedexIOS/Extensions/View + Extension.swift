//
//  View + Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func wrappedInScroll(_ isWrapped: Bool, axis: Axis.Set) -> some View {
        if isWrapped {
            ScrollView(axis) {
                self
            }
        } else {
            self
        }
    }
}
