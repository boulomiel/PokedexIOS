//
//  PokemonStatView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI
import Combine

struct PokemonStatsView: View {
    
    //Constructor
    let pokemonStats: [PokemonDisplayStat]
    let backgroundColor: Color
    let dataColor: Color
    let strokeLine: Color
    
    @State var viewHeight: CGFloat
    
    init(pokemonStats: [PokemonDisplayStat], backgroundColor: Color, dataColor: Color, strokeLine: Color) {
        self.pokemonStats = pokemonStats
        self.backgroundColor = backgroundColor
        self.dataColor = dataColor
        self.strokeLine = strokeLine
        self.viewHeight = 0
    }
    
    
    var body: some View {
        GeometryReader { geo in
            let frame = geo.frame(in: .local)
            let radius = (frame.width / 2) - 50
            StatBackgroundShape(radius: radius)
                .fill(backgroundColor)
                .overlay(content: {
                    StatBackgroundShape(radius: radius)
                        .stroke()
                        .foregroundStyle(strokeLine)
                })
                .overlay {
                    StatShape(radius: radius, stats: .init(values: pokemonStats.map(\.value)))
                        .fill(dataColor)
                        .animation(.easeIn, value: pokemonStats)

                }
                .overlay {
                    statsTitleLayers(frame: frame)
                }
                .onAppear(perform: {
                    viewHeight = radius*2 + 50
                })
        }
        .frame(height: viewHeight)
        .transition(.scale)

    }
    
    @ViewBuilder
    private func statsTitleLayers(frame: CGRect) -> some View {
        let center = CGPoint(x: frame.midX, y: frame.height/2)
        ForEach(0..<pokemonStats.count, id: \.self) { index in
            let stat = pokemonStats[index]
            let position = pos(for: (Double(index*2) * .pi / 6 - .pi / 2), with: (frame.width / 2), center: center)
            Text(stat.displayName)
                .bold()
                .font(.caption)
                .minimumScaleFactor(0.1)
                .position(position)
        }
    }
    
    private func pos(for angle: Double,
                     with radius: Double,
                     center: CGPoint) -> CGPoint {
        var x = (radius-25) * cos(angle)
        var y = (radius-25) * sin(angle)
        x += center.x
        y += center.y
        return CGPoint(x: x, y: y)
    }
}
