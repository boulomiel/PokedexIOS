//
//  StatShape.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI
import Accelerate

public struct AnimatableVector: VectorArithmetic, Sendable {
    public static var zero = AnimatableVector(values: [0.0])
    
    public static func + (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        let count = min(lhs.values.count, rhs.values.count)
        return AnimatableVector(values: vDSP.add(lhs.values[0..<count], rhs.values[0..<count]))
    }
    
    public static func += (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        let count = min(lhs.values.count, rhs.values.count)
        vDSP.add(lhs.values[0..<count], rhs.values[0..<count], result: &lhs.values[0..<count])
    }
    
    public static func - (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        let count = min(lhs.values.count, rhs.values.count)
        return AnimatableVector(values: vDSP.subtract(lhs.values[0..<count], rhs.values[0..<count]))
    }
    
    public static func -= (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        let count = min(lhs.values.count, rhs.values.count)
        vDSP.subtract(lhs.values[0..<count], rhs.values[0..<count], result: &lhs.values[0..<count])
    }
    
    public var values: [Double]
    
    public mutating func scale(by rhs: Double) {
        values = vDSP.multiply(rhs, values)
    }
    
    public var magnitudeSquared: Double {
        vDSP.sum(vDSP.multiply(values, values))
    }
}

public struct StatShape: Shape {
    
    public var animatableData: AnimatableVector {
        get { stats }
        set { stats = newValue }
    }
    
    var radius: CGFloat = 180
    var stats: AnimatableVector
    
    public func path(in rect: CGRect) -> Path {
        let viewCenter = CGPoint(x: rect.midX, y: rect.midY)
        return Path { p in
            stats.values.enumerated().forEach { i, stat in
                var point = pos(for: (Double(i*2) * .pi / 6 - .pi / 2), ratio: stat) // - .pi / 2 : -90 degress otherwises starts from right
                point.x += viewCenter.x
                point.y += viewCenter.y
                if i == 0 {
                    p.move(to: point)
                } else {
                    p.addLine(to: point)
                }
            }
            p.closeSubpath()
        }
    }
    
    private func makePoints(in center: CGPoint) -> [CGPoint] {
        return stats.values.enumerated().map { i, stat in
            var point = pos(for: (Double(i*2) * .pi / 6 - .pi / 2), ratio: stat)
            point.x += center.x
            point.y += center.y
            return point
        }
    }
    
    private func pos(for angle: Double, ratio: Double) -> CGPoint {
        let x = radius * ratio * cos(angle)
        let y = radius * ratio * sin(angle)
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    PokemonStatsView(pokemonStats: pokemonStats, backgroundColor: .red, dataColor: .yellow, strokeLine: .orange)
}


var randomDouble: Double {
    Double.random(in: 0...1)
}

var pokemonStats: [PokemonDisplayStat] = [
    .init(name: "Hello", value: randomDouble),
    .init(name: "Hello", value: randomDouble),
    .init(name: "Hello", value: randomDouble),
    .init(name: "Hello", value: randomDouble),
    .init(name: "Hello", value: randomDouble),
    .init(name: "Hello", value: randomDouble)
]
