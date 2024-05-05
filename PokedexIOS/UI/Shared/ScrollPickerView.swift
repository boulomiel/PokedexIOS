//
//  LanguagePickerView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import Foundation
import SwiftUI

struct ScrollPickerView: View {
    let options: [String]
    @Binding var selected: String
    
    private var sortedOptions: [String] {
        options
    }
    
    private var selectedIndex: Int {
        sortedOptions.firstIndex(of: selected) ?? 0
    }
    
    private var previousIndex: Int {
        if let previousSelection {
            sortedOptions.firstIndex(of: previousSelection) ?? 0
        } else {
            selectedIndex
        }
    }
    private let viewHeight: CGFloat = 30
    @State private var previousSelection: String?
    @State private var scrollPosition: String?
    @Namespace var scrollPickerView
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let frame = geo.frame(in: .global)
                    ScrollView(.horizontal) {
                            HStack {
                                ForEach(sortedOptions, id: \.self) { option in
                                    Text(option.capitalized)
                                        .bold()
                                        .font(.caption)
                                        .frame(width: frame.width / 3, height: viewHeight)
                                        .background(option == selected ? selectedBackound : nil)
                                        .overlay(alignment: .leading) {
                                            if option != selected && option != sortedOptions.first {
                                                sideLine
                                            }
                                        }
                                        .onTapGesture {
                                            withAnimation(.snappy){
                                                selected = option
                                            }
                                        }
                                }
                            }
                            .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .scrollPosition(id: $scrollPosition)
                    .onChange(of: selected, { oldValue, newValue in
                        previousSelection = newValue
                        Vibrator.selection()
                    })
                    .onChange(of: scrollPosition) { oldValue, newValue in
                        if let newValue {
                            selected = newValue
                        }
                    }
            }
            .frame(height: viewHeight)
            .background(scrollBackground)
            .animation(.snappy, value: selected)

        }
    }
    
    var sideLine: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 1, height: viewHeight/2)
    }
    
    var selectedBackound: some View {
        RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.6))
            .transition(.asymmetric(insertion: .move(edge: previousIndex < selectedIndex ? .leading : .trailing), removal: .opacity))
    }
    
    var scrollBackground: some View {
        RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.3))
            .shadow(radius: 4)
    }
}
