//
//  MoveSectionContentCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 25/04/2024.
//

import SwiftUI
import Resources
import Tools
import DI
import Dtos

public struct MoveSectionContentCell: View {
    
    let moves: [Move]
    @State private var showDescription: Bool = false
    
    public var body: some View {
        VStack {
            ForEach(moves) { move in
                Cell(move: move)
            }
        }
    }
    
    public struct Cell: View {
        
        let move: Move
        @State private var showDescription: Bool = false

        public var body: some View {
            VStack {
                titleRow(move: move)
                if showDescription {
                    descriptionRow(move: move)
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .identity))
                }
            }
            .onTapGesture {
                Vibrator.change(of: .light)
                withAnimation {
                    showDescription.toggle()
                }
            }
        }
        
        func titleRow(move: Move) -> some View {
            HStack {
                ShrinkText(text: move.name.capitalized, alignment: .leading, font: .body.bold())
                    .padding(3)
                    .background(RoundedRectangle(cornerRadius: 2).fill(Color.gray.opacity(0.3)))
                MoveDamageType(rawValue: move.damageClass.name)!
                    .image(width: 60, height: 30)
                Text("\(move.pp) PP")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(3)
                
                move.Icon(25)
            }
        }
        
        func descriptionRow(move: Move) -> some View {
            Text(move.effectEntries.first(where: { $0.language.name == "en" })?.shortEffect ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    let moves = JsonReader.readMoves()
    return MoveSectionContentCell(moves: moves)
        .preferredColorScheme(.dark)
        .padding(.horizontal, 40)

}
