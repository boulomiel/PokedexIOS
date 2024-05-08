//
//  PokeballImageAsync.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import SwiftUI
import Resources

public struct PokeballImageAsync: View {
    
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    
    @State private var isShown: Bool = false
    @State private var id: UUID = .init()

    public var body: some View {
        ZStack {
            if isShown {
                ScaleAsyncImage(url: url)
                    .onTapGesture {
                        isShown = false
                        id = .init()
                    }
            } else {
                PokebalView(radius: width / 7)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.snappy) {
                                isShown = true
                            }
                        }
                    })
            }
        }
        .id(id)
    }
}

#Preview {
    @Environment(\.diContainer ) var container
    let spriteURL = JsonReader.readPokemons().randomElement()!.sprites?.frontDefault
    let width: CGFloat =  80
    let height: CGFloat = 80
    return PokeballImageAsync(url: spriteURL, width: width, height: height)
        .inject(container:  container)
        .preferredColorScheme(.dark)
}
