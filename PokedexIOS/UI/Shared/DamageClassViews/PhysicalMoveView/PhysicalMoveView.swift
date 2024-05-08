//
//  PhysicalMoveView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation
import SwiftUI

public struct PhysicalMoveView: View {
    
    public var body: some View {
        GeometryReader { geo  in
            let frame = geo.frame(in: .local)
            PhysicalMoveShape()
                .fill(Color.yellow.gradient)
                .padding(4)
                .frame(width: frame.height*2.2, height: frame.height) // width = 2,2 * height
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.orange.gradient))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 8).foregroundColor(Color.red))
                .padding(3)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.white))
        }
    }
}

public struct PhysicalMoveView2: View {
    
    var height: CGFloat = 45
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.yellow.gradient)
                .clipShape(PhysicalMoveShape())
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.orange.gradient))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 8).foregroundColor(Color.red))
                .padding(3)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.white))
        }
        .frame(width: height * 2.2, height: height) // width = 2,2 * height

    }
}

#Preview  {
    PhysicalMoveView2()
}
