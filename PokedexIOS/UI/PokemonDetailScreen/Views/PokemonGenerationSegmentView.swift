//
//  PokemonGenerationSegmentView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI

public struct PokemonGenerationSegmentView: View {
    
    @Bindable var provider: Provider
    
    public var body: some View {
        Picker("Hello", selection: $provider.selected) {
            ForEach(provider.generations, id: \.id) {
                Text($0.id)
                    .minimumScaleFactor(0.1)
                    .tag($0)
            }
        }
        .pickerStyle(.segmented)
        .onChange(of: provider.selected) { _, _ in
            Vibrator.selection()
        }
    }
    
    @Observable
   public class Provider {
        var generations: [GenModel]
        var selected: GenModel
        
        init(data: SegmentData) {
            self.generations = data.genModels
            self.selected = data.selected
        }
        
    }
}


#Preview {
    let models: [GenModel] = [.init(id: "1", sprite: nil),
                              .init(id: "2", sprite: nil),
                              .init(id: "3", sprite: nil)]
    return PokemonGenerationSegmentView(provider: .init(data: .init(genModels: models,
                                                             selected: .init(id: "1", sprite: nil))))
}
