//
//  StatusMoveView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import Foundation
import SwiftUI

public struct StatusMoveView: View {
    
    public var body: some View {
        GeometryReader { geo  in
            let frame = geo.frame(in: .local)
            ZStack {
                StatusOvalMoveShape()
                    .fill(Color.white)
                    .foregroundStyle(.white)
                
                StatusMoveShape()
                    .fill()
                    .foregroundStyle(Color.gray.gradient)

            }
            .frame(width: frame.height * 2.2, height: frame.height) // width = 2,2 * height
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.gradient))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 8).foregroundColor(Color.gray.opacity(0.5)))
            .padding(3)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.white))
        }
        
    }
}

public struct StatusMoveView2: View {
    
    var height: CGFloat = 35
    
    public var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.white)
                .clipShape(StatusOvalMoveShape())
            
            Rectangle()
                .fill(Color.gray.gradient)
                .clipShape(StatusMoveShape())
        }
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.gradient))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 8).foregroundColor(Color.gray.opacity(0.5)))
        .padding(3)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.white))
        .frame(width: height * 2.2, height: height) // width = 2,2 * height
    }
}

#Preview {
    StatusMoveView2()
}
