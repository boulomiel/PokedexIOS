//
//  SpecialMoveShape.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation
import SwiftUI

struct SpecialMoveShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.midX, y: rect.minY+8)

        let path = Path { p in
            p.move(to: start)
            p.addEllipse(in: .init(origin: .init(x: rect.width * 0.15, y: rect.minY+8), size: .init(width: rect.width * 0.7, height: rect.height - 16)))
        }
        
        return scaledPath(path: path, in: rect)
    }
}


struct SpecialMoveView: View {
    
    let deepDarkBlue = Color("DeepDarkBlue")
    let darkBlue = Color("DarkBlue")
    let lightBlue = Color("LightBlue")
    
    var body: some View {
        GeometryReader { geo  in
            let frame = geo.frame(in: .local)
            VStack {
                SpecialMoveShape()
                    .fill(lightBlue)
                    .overlay {
                        SpecialMoveShape()
                            .fill(darkBlue)
                            .scaleEffect(x: 0.85, y: 0.8)
                            .overlay {
                                SpecialMoveShape()
                                    .fill(lightBlue)
                                    .scaleEffect(x: 0.65, y: 0.6)
                                    .offset(y: -4)
                                    .overlay {
                                        SpecialMoveShape()
                                            .fill(darkBlue)
                                            .scaleEffect(x: 0.45, y: 0.35)
                                            .offset(y: -4)
                                            .overlay {
                                                SpecialMoveShape()
                                                    .fill(lightBlue)
                                                    .scaleEffect(x: 0.30, y: 0.20)
                                                    .offset(y: -4)
                                            }
                                    }
                            }
                    }
            }
            .padding(4)
            .frame(width: frame.height * 2.2, height: frame.height) // width = 2,2 * height
            .background(RoundedRectangle(cornerRadius: 8).fill(darkBlue))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 8).foregroundColor(deepDarkBlue))
            .padding(3)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.white))
        }
    }
}

struct SpecialMoveView2: View {
    
    let deepDarkBlue = Color("DeepDarkBlue")
    let darkBlue = Color("DarkBlue")
    let lightBlue = Color("LightBlue")
    var height: CGFloat = 45
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(lightBlue)
                .clipShape(SpecialMoveShape())
            
            Rectangle()
                .fill(darkBlue)
                .clipShape(SpecialMoveShape())
                .scaleEffect(x: 0.85, y: 0.8)
            
            Rectangle()
                .fill(lightBlue)
                .clipShape(SpecialMoveShape())
                .scaleEffect(x: 0.65, y: 0.6)
                .offset(y: -4)
            
            Rectangle()
                .fill(darkBlue)
                .clipShape(SpecialMoveShape())
                .scaleEffect(x: 0.45, y: 0.35)
                .offset(y: -4)
            
            Rectangle()
                .fill(lightBlue)
                .clipShape(SpecialMoveShape())
                .scaleEffect(x: 0.30, y: 0.20)
                .offset(y: -4)

        }
        .background(RoundedRectangle(cornerRadius: 8).fill(darkBlue))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 8).foregroundColor(deepDarkBlue))
        .padding(3)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.white))
        .frame(width: height * 2.2, height: height)
    }
}

#Preview {
    SpecialMoveView2()
        .preferredColorScheme(.dark)
}
