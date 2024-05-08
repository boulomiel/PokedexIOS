//
//  PhysicalMoveShape.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation
import SwiftUI

public struct PhysicalMoveShape: Shape {
    
    public func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.minY+8)
        let path =  Path { p in
            ///RIGHT HALF -> from top to bottom
            p.move(to: start)
            p.addLine(to: .init(x: rect.width/2+20, y: rect.height*0.25))
            p.addLine(to: .init(x: rect.width * 0.75, y: rect.height*0.15))
            p.addLine(to: .init(x: rect.width * 0.70, y: rect.height * 0.35))
            p.addLine(to: .init(x: rect.width * 0.90, y: rect.height * 0.5))
            p.addLine(to: .init(x: rect.width * 0.70, y: rect.height * 0.65))
            p.addLine(to: .init(x: rect.width * 0.75, y: rect.height*0.85))
            p.addLine(to: .init(x: rect.width/2+20, y: rect.height*0.75))
            ///LEFT HALF -> from bottom to top
            p.addLine(to: .init(x: rect.width/2, y: rect.height-8))
            p.addLine(to: .init(x: rect.width/2-20, y: rect.height*0.75))
            p.addLine(to: .init(x: rect.width * 0.25, y: rect.height*0.85))
            p.addLine(to: .init(x: rect.width * 0.30, y: rect.height * 0.65))
            p.addLine(to: .init(x: rect.width * 0.1, y: rect.height * 0.5))
            p.addLine(to: .init(x: rect.width * 0.30, y: rect.height * 0.35))
            p.addLine(to: .init(x: rect.width * 0.25, y: rect.height*0.15))
            p.addLine(to: .init(x: rect.width/2-20, y: rect.height*0.25))
            p.closeSubpath()
        }
        return scaledPath(path: path, in: rect)

    }
}

#Preview {
    PhysicalMoveView()
        .frame(height: 60)
}
