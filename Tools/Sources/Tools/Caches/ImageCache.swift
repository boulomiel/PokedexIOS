//
//  ImageCache.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 18/04/2024.
//

import Foundation
import UIKit

protocol ImageCacheProtocol: Actor {
    associatedtype CacheType
    var cache: CacheType { get set}
    var child: (any ImageCacheProtocol)? { get }
    func set(url: URL?, image: UIImage) async
    func get(url: URL?) async -> UIImage?
}

public actor ImageCache: ImageCacheProtocol {
    typealias CacheType = NSCache<NSURL, UIImage>
    
    var cache: NSCache<NSURL, UIImage>
    var child: (any ImageCacheProtocol)?
    private let session: URLSession

    public init(cache: NSCache<NSURL, UIImage> = .init()) {
        self.cache = cache
        self.child = ImageDocumentCache()
        self.session = .init(configuration: .ephemeral)
    }
    
    func set(url: URL?, image: UIImage) async {
        if let url = url, let nsurl = NSURL(string: url.absoluteString) {
            cache.setObject(image, forKey: nsurl)
        } else {
            print(#file, "\n", #function, "url could not be saved")
        }
    }
    
    public func get(url: URL?) async -> UIImage? {
        return await getFrom(url: url)
    }
    
    private func getFrom(url: URL?) async -> UIImage? {
        if let url = url {
            if let object = getSync(url: url) {
                return object
            } else {
                do {
                    let (data, _) = try await session.data(from: url)
                    if let image = UIImage(data: data) {
                        await set(url: url, image: image)
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
    
    private func getSync(url: URL?) -> UIImage? {
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
}

public actor ImageDocumentCache: ImageCacheProtocol {
    
    private var directoryPath: URL {
        URL.temporaryDirectory
    }
    
    typealias CacheType = Int
    var cache: Int
    var child: (any ImageCacheProtocol)?
    
    init(cache: Int = 0, child: (any ImageCacheProtocol)? = nil) {
        self.cache = cache
        self.child = child
    }
    
    private func save(url: URL?, image: UIImage?) {
        guard let url, let data = image?.pngData() else { return }
        do {
            try data.write(to: directoryPath.appendingPathComponent("\(url.lastPathComponent)"))
        } catch {
            print(#function, error)
        }
    }
    
    private func retrieve(url: URL?) -> UIImage? {
        guard let url else { return nil }
        let imagePath = directoryPath.appendingPathComponent("\(url.lastPathComponent)").path()
        guard let url = URL(string: imagePath) else { return nil }

        do {
            return try UIImage(contentsOfFile: imagePath)
        } catch {
            print(#function, error)
            return nil
        }
    }
    
    func set(url: URL?, image: UIImage) async {
        save(url: url, image: image)
    }
    
    func get(url: URL?) async -> UIImage? {
        retrieve(url: url)
    }
}
