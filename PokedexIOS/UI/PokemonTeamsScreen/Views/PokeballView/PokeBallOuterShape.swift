//
//  PokeBallShape.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftUI

public struct PokeBallTopShape: Shape {
    
    public func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.maxY)
        let outerPath = Path { p in
            p.addArc(center: start, radius: rect.width * 0.5, startAngle: .radians(.pi), endAngle: .radians(.zero), clockwise: false)
            p.addLine(to: .init(x: rect.width*0.7, y: rect.maxY))
            p.addArc(center: start, radius: rect.width * 0.15, startAngle: .radians(.zero), endAngle: .radians(.pi), clockwise: true)
            p.closeSubpath()
        }
        return outerPath
    }
}

public struct PokeBallBottomShape: Shape {
    
    public func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.maxY)
        let outerPath = Path { p in
            p.addArc(center: start, radius: rect.width * 0.5, startAngle: .radians(.zero), endAngle: .radians(.pi), clockwise: false)
            p.addLine(to: .init(x: rect.width*0.7, y: rect.maxY))
            p.addArc(center: start, radius: rect.width * 0.15, startAngle: .radians(.pi), endAngle: .radians(.zero), clockwise: true)
            p.closeSubpath()
        }
        return scaledPath(path: outerPath, in: rect)
    }
}

public struct TestBeltView: View {
    
    let count: Int = 6
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<count, id: \.self) { i in
                    PokebalView(radius: 25)
                }
            }
        }
    }
    
}


#Preview {
    TestBeltView()
        .preferredColorScheme(.dark)
}
