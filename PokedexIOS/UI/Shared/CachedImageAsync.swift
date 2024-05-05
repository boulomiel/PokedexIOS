//
//  CachedImageAsync.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import Foundation
import SwiftUI

struct CachedAsyncImage: View {
    
    @DIContainer var imageCache: ImageCache
    var url: URL?
    var width: CGFloat
    var height: CGFloat
    @State private var image: UIImage?

    var body: some View {
        imageView
    }
    
    @ViewBuilder
    var imageView: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
            } else {
                PokebalView(radius: width * 0.3)
            }
        }
        .frame(width: width, height: height)
        .task {
            await getImage()
        }
    }
    
    func getImage() async {
        let image = await imageCache.get(url: url)
        await MainActor.run {
            self.image = image
        }
    }
}
