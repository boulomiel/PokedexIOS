//
//  CriePlayer.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import Foundation
@preconcurrency import AVFoundation
@preconcurrency import OggDecoder

@Observable
final public class CriePlayer: Sendable {
    
    let decoder: OGGDecoder
    let session: AVAudioSession
    nonisolated(unsafe) private var player: AVAudioPlayer?
    nonisolated(unsafe) public var isMuted: Bool
    
    public init(session: AVAudioSession = .sharedInstance(), player: AVAudioPlayer? = nil) {
        self.decoder = .init()
        self.session = session
        self.player = player
        self.isMuted = true
    }
    
    public func play(_ url: URL?) async {
        guard isMuted else { return }
        guard let remoteURL = url else { return }
        do {
            let (data, _) =  try await URLSession.shared.data(from: remoteURL)
            let localURL = URL.temporaryDirectory.appendingPathComponent(remoteURL.lastPathComponent)
            try data.write(to: localURL)
            guard let fileURL = await decoder.decode(localURL) else {
                throw NSError(domain: String(describing: Self.self), code: -1, userInfo: ["description": "Could not decodedthe file for \(remoteURL)"])
            }
            try session.setCategory(.playback)
            try session.setActive(true)
            player = try .init(contentsOf: fileURL)
            player?.volume = 0.8
            player?.setVolume(0.2, fadeDuration: 0.5)
            player?.play()
        } catch let error as NSError {
            print(#file, #function, error)
        }
    }
}
