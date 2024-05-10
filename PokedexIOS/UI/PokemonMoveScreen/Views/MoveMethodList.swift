//
//  MoveMethodList.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import SwiftUI
import DI
import Dtos

public struct MethodMoveList: View {
    
    let width: CGFloat
    let provider: Provider
    
    public var body: some View {
        VStack {
            Text(provider.method.rawValue.capitalized)
                .bold()
                .frame(maxWidth: width, alignment: .leading)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.3)))
            ForEach(provider.providers, id: \.id) { provider in
               MoveViewCell(provider: provider, width: width)
            }
        }
        .padding(.bottom)
    }
    
    @Observable
   public class Provider {
        let method: MoveLearnMethodType
        let moveApi: PokemonMoveApi
        let generalApi: GeneralApi<Machine>
        var providers: [MoveViewCell.Provider]
        
        init(method: MoveLearnMethodType, moveApi: PokemonMoveApi, generalApi: GeneralApi<Machine>, methodMove: [MoveVersionMeta]) {
            self.generalApi = generalApi
            self.method = method
            self.moveApi = moveApi
            self.providers = []
            makeProviders(methodMove: methodMove)
        }
        
        private func makeProviders(methodMove: [MoveVersionMeta]) {
            providers = methodMove.map { move in
                MoveViewCell.Provider(moveApi: moveApi, generalApi: generalApi, moveVersionData: move)
            }
        }
    }
}
