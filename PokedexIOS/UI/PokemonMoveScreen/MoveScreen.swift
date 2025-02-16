//
//  MoveView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import SwiftUI
import DI
import Dtos

public struct MoveScreen: View {
    
    @DIContainer private var moveApi: PokemonMoveApi
    @DIContainer private var machineApi: PokemonMachineApi
    @DIContainer private var generalApi: GeneralApi<Machine>

    @State var provider: Provider
    
    public var body: some View {
        VStack {
            ScrollPickerView(options: provider.versions, selected: $provider.selectedVersions)
            GeometryReader {  geo in
                let width = geo.frame(in: .global).width
                ScrollView {
                    ForEach(provider.methods, id:\.self) { method in
                        moveListByMethod(method, width: width)
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func moveListByMethod(_ method: MoveLearnMethodType, width: CGFloat) -> some View {
        MethodMoveList(width: width, provider: .init(method: method, moveApi: moveApi, generalApi: generalApi, methodMove: provider.getByMethods(method)))
    }
    
    @Observable
   public final class Provider {
        
        let moveData: MoveData
        
        var movesByMethodes: [MoveLearnMethodType: [MoveVersionMeta]]
        var versions: [String]
        var selectedVersions: String
        
        var meta: [MoveVersionMeta] {
            return moveData.metaVersions
                .sorted(by:{$0.levelLearntAt < $1.levelLearntAt})
                .filter({ $0.version.rawValue == selectedVersions })
        }
        var methods: [MoveLearnMethodType] {
            Array(movesByMethodes.keys).sorted(by: { $0.id < $1.id})
        }
        
        init(moveData: MoveData) {
            self.moveData = moveData
            self.selectedVersions = moveData.metaVersions.first!.version.rawValue
            self.versions = Set(moveData.metaVersions.map(\.version))
                .sorted(by: { $0.id < $1.id })
                .removeUnwanted()
                .map(\.rawValue)
            self.movesByMethodes = Dictionary.init(grouping: moveData.metaVersions) { meta in
                meta.learningMethod
            }
        }
        
        func getByMethods(_ method: MoveLearnMethodType) -> [MoveVersionMeta] {
            movesByMethodes[method]?
                .sorted(by:{$0.levelLearntAt < $1.levelLearntAt})
                .filter({ $0.version.rawValue == selectedVersions }) ?? []
        }
    }
}

public struct MoveCellData: Hashable {
    var query: PokemonMoveQuery
    var versionMeta: MoveVersionMeta
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    let meta1 = MoveVersionMeta(moveName: "thunder", version: .yellow, levelLearntAt: 15, learningMethod: .levelUp)
    let meta2 = MoveVersionMeta(moveName: "scratch", version: .blackAndWhite, levelLearntAt: 15, learningMethod: .levelUp)
    let meta3 = MoveVersionMeta(moveName: "petal-dance", version: .yellow, levelLearntAt: 15, learningMethod: .egg)
    let meta4 = MoveVersionMeta(moveName: "double-edge", version: .yellow, levelLearntAt: 15, learningMethod: .levelUp)

    return MoveScreen(provider: .init(moveData: .init(metaVersions: [meta1, meta2, meta3, meta4])))
    
    .inject(container: container)
    .preferredColorScheme(.dark)
}
