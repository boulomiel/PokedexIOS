//
//  ShrinkText.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import SwiftUI

struct ShrinkText: View {
    
    private let text: String
    private let alignment: Alignment
    private let font: Font
    private let width: CGFloat?
    private let lineLimit: Int?
    
    public init(text: String, alignment: Alignment, font: Font,  width: CGFloat? = nil, lineLimit: Int? = 1) {
        self.text = text
        self.alignment = alignment
        self.font = font
        self.width = width
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        if let width {
            Text(text)
                .frame(width: width, alignment: alignment)
                .minimumScaleFactor(0.1)
                .font(font)
                .lineLimit(lineLimit)
        } else {
            Text(text)
                .frame(maxWidth: .infinity, alignment: alignment)
                .minimumScaleFactor(0.1)
                .font(font)
                .lineLimit(lineLimit)
        }
    }
}
