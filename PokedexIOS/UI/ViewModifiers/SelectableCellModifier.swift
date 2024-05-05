//
//  SelectableCellModifier.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import Foundation
import SwiftUI

struct SelectableCellModifier: ViewModifier {
    
    @Binding var isSelected: Bool
    let isSelectable: Bool
    let alignment: Alignment
    let padding: EdgeInsets
    
    @State private var show: Bool = false
    @State private var id: UUID = .init()

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                if isSelectable, show {
                    SelectionIndicatorView(isSelected: $isSelected)
                        .padding(padding)
                        .transition(.scale)
                }
            }
            .onChange(of: isSelectable, initial: true, { oldValue, newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.snappy) {
                        show = newValue
                    }
                }
            })
    }
}

extension View {
    func onSelection(isSelected: Binding<Bool>, isSelectable: Bool,  alignment: Alignment, padding: EdgeInsets) -> some View {
        modifier(SelectableCellModifier(isSelected: isSelected, isSelectable: isSelectable, alignment: alignment, padding: padding))
    }
}
