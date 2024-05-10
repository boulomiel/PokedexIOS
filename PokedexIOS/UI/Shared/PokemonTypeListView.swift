//
//  PokemonTypeListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 10/05/2024.
//

import Foundation
import SwiftUI
import Dtos

struct PokemonTypeListView: View {
    typealias Types = PokemonType.PT
    
    let types: [Types]
    let imageSize: CGFloat
    
    var body: some View {
        HStack {
            ForEach(types, id:\.rawValue) {
                $0.image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundStyle($0.gradient)
                    .padding(2)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.3))
                    }
            }
        }
    }
}
