//
//  ScaleAsyncImage.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import SwiftUI
import Tools
import DI

public struct ScaleAsyncImage: View {
    
    @DIContainer var imageCache: ImageCache
    
    var url: URL?
    var width: CGFloat = 80
    var height: CGFloat = 80
    @State var shouldAnimate: Bool = false
    @State private var id: UUID = .init()
    
    public var body: some View {
        ZStack {
            CachedAsyncImage(url: url, width: width, height: height)
                .clipped()
                .id(id)
                .onChange(of: url) { oldValue, newValue in
                    withAnimation(.smooth) {
                        id = .init()
                    }
                }
                .scaleEffect(shouldAnimate ? 1 : 0)
                .onAppear(perform: {
                    withAnimation(.smooth.delay(0.1)) {
                        shouldAnimate = true
                    }
                })
        }
        .frame(width: width, height: height)
    }
}
