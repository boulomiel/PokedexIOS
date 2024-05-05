//
//  StatusMoveShape.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation
import SwiftUI

struct StatusMoveShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.width * 0.18, y: rect.midY)

        let path = Path { p in
            p.move(to: start)
            p.addQuadCurve(to: .init(x: rect.width * 0.55, y: rect.height * 0.2), control: .init(x: rect.width * 0.32, y: rect.height * 0.1))
            p.addQuadCurve(to: .init(x: rect.width * 0.5, y: rect.height * 0.55), control: .init(x: rect.width * 0.3, y: rect.height * 0.35))
            p.addQuadCurve(to: .init(x: rect.width * 0.5, y: rect.height * 0.65), control: .init(x: rect.width * 0.55, y: rect.height * 0.6))
            p.addQuadCurve(to: start, control:  .init(x: rect.width * 0.32, y: rect.height * 0.75))
            p.closeSubpath()

        }
        return path
    }
}

struct StatusOvalMoveShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.minY+8)
        let path = Path { p in
            p.move(to: start)
            p.addEllipse(in: .init(origin: .init(x: rect.width * 0.15, y: rect.minY+8), size: .init(width: rect.width * 0.7, height: rect.height - 16)))
        }
        return scaledPath(path: path, in: rect)
    }
}

#Preview {
    StatusMoveView()
        .frame(height: 50)
}


extension Shape {
    /// point = original point
    /// offset = in case the origin of `boundingRect` isn't (0,0), make sure to offset each point
    /// scale = how much to scale the point by
    func convertPoint(_ point: CGPoint, offset: CGPoint, scale: CGFloat) -> CGPoint {
        return CGPoint(x: (point.x - offset.x) * scale, y: (point.y - offset.y) * scale)
    }
    
    func scaledPath(path: Path, in rect: CGRect) -> Path {
        let boundingRect = path.boundingRect
        let scale = min(rect.width/boundingRect.width, rect.height/boundingRect.height)
        let scaled = path.applying(.init(scaleX: scale, y: scale))
        let scaledBoundingRect = scaled.boundingRect
        let offsetX = scaledBoundingRect.midX - rect.midX
        let offsetY = scaledBoundingRect.midY - rect.midY

        return scaled.offsetBy(dx: -offsetX, dy: -offsetY)
    }
}

