//
//  ImageCache.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import UIKit

public actor ImageCache {
    
    var cache: NSCache<NSURL, UIImage>
    private let session: URLSession = .init(configuration: .ephemeral)
    
    public init() {
        self.cache = .init()
    }
    
    public func set(url: URL?, image: UIImage) {
        if let url = url, let nsurl = NSURL(string: url.absoluteString) {
            cache.setObject(image, forKey: nsurl)
        } else {
            print(#file, "\n", #function, "url could not be saved")
        }
    }
    
    public func getSync(url: URL?) -> UIImage? {
        if let url = url, let nsurl = NSURL(string: url.absoluteString) {
            if let object = cache.object(forKey: nsurl) {
                return object
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public func get(url: URL?) async -> UIImage? {
        if let url = url {
            if let object = getSync(url: url) {
                return object
            } else {
                do {
                    let (data, _) = try await session.data(from: url)
                    if let image = UIImage(data: data) {
                        self.set(url: url, image: image)
                        return image
                    }
                    return await get(url: url)
                } catch {
                    print(#file, "\n", #function, error)
                    return nil
                }
            }
        } else {
            return nil
        }
    }
}
