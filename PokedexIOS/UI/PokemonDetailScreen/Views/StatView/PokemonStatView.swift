//
//  PokemonStatView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI
import Combine
import Resources
import DI

public struct PokemonStatsView: View {
    
    @Environment(\.isIphone) private var isIphone
    @Environment(\.isLandscape) private var isLandscape
    
    //Conpublic structor
    let pokemonStats: [PokemonDisplayStat]
    let backgroundColor: Color
    let dataColor: Color
    let strokeLine: Color
    let radius: CGFloat
    
    init(pokemonStats: [PokemonDisplayStat], backgroundColor: Color, dataColor: Color, strokeLine: Color, radius: CGFloat = 100) {
        self.pokemonStats = pokemonStats
        self.backgroundColor = backgroundColor
        self.dataColor = dataColor
        self.strokeLine = strokeLine
        self.radius = radius
    }
    
    public var body: some View {
        StatBackgroundShape(radius: radius)
            .fill(backgroundColor)
            .coordinateSpace(.named("StatSpace"))
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
                statsTitleLayers(frame: .zero)
            }
            .frame(width: 3.5 * radius, height: 3.5 * radius)
            .transition(.scale)
    }
    
    @ViewBuilder
    private func statsTitleLayers(frame: CGRect) -> some View {
        GeometryReader { geo in
            let frame = geo.frame(in: .named("StatSpace"))
            let center =  CGPoint(x: frame.width/2, y: frame.height/2)
            let width =  (frame.width / 2)
            ForEach(0..<pokemonStats.count, id: \.self) { index in
                let stat = pokemonStats[index]
                let position = pos(for: (Double(index*2) * .pi / 6 - .pi / 2), with: width, center: center)
                ShrinkText(text: stat.displayName, alignment: .center, font: .caption.bold(), lineLimit: 2)
                    .position(position)
            }
        }
    }
    
    private func pos(for angle: Double,
                     with radius: Double,
                     center: CGPoint) -> CGPoint {
        var x = (radius * 0.80) * cos(angle)
        var y = (radius * 0.80) * sin(angle)
        x += center.x
        y += center.y
        return CGPoint(x: x, y: y)
    }
}


#Preview {
    let dracolosse = JsonReader.readPokemons().randomElement()!
    let displayStat = dracolosse.stats.map { PokemonDisplayStat(name: $0.stat.name, value: Double($0.baseStat)/200) }
    return PokemonStatsView(pokemonStats: displayStat, backgroundColor: .black, dataColor: .blue, strokeLine: .white)
}
