//
//  StatBackgroundShape.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI

public struct StatBackgroundShape: Shape {
    
    var radius: CGFloat = 180
    var statCount: Int = 6
        
    public func path(in rect: CGRect) -> Path {
        let viewCenter = CGPoint(x: rect.midX, y: rect.midY)
        var points = makeBackgroundPoints(in: viewCenter)
        return Path { p in
            p.move(to: points.removeFirst())
            while !points.isEmpty {
                p.addLine(to: points.removeFirst())
            }
            p.closeSubpath()
        }
    }
    
    private func makeBackgroundPoints(in center: CGPoint) -> [CGPoint] {
        var points: [CGPoint] = []
        let count = statCount * 2
        for i in 0...count {
            var point = pos(for: Double(i) * .pi / 6)
            point.x += center.x
            point.y += center.y
            points.append(point)
        }
        
        return points
    }
    
    private func pos(for angle: Double) -> CGPoint {
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}
