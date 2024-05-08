//
//  MoveViewCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import SwiftUI

public struct MoveViewCell: View {
    
    let provider: Provider
    let width: CGFloat
    @State private var selectedMove: MoveItemDataHolder?
    
    public var body: some View {

        if let move = provider.moveItemHolder {
            NavigationLink(value: MoveDetailsRoute(move: move)) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .center) {
                        moveTitleType(move: move)
                        move.damageClass.image(width: 70, height: 30)
                    }
                    HStack {
                        moveTextLearnAt(width: width * 0.4)
                        moveTextAtLevel(width: width * 0.2)
                        seeMoveButton
                    }
                    
                    Rectangle()
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .frame(height: 2)
                        .padding(.top, 2)
                    
                }
            }
            .foregroundStyle(.white)
            .animation(.easeIn, value: provider.moveItemHolder)
            
        }
        
    }
    
    func moveTitleType(move: MoveItemDataHolder) -> some View {
        HStack {
                Image(move.type)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(4)
                    .background(Circle().stroke().foregroundStyle(.white))
            
                Text(move.name.first(where: { $0.language == "en" })?.name ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .bold()
            
        }
        .padding(.leading, 2)
    }
    
    func moveTextLearnAt(width: CGFloat) -> some View {
        Text(provider.config.methodText)
            .frame(maxWidth: width, alignment: .leading)
    }
    
    @ViewBuilder
    func moveTextAtLevel(width: CGFloat) -> some View {
        Text(provider.moveTextAtLevel)
            .frame(maxWidth: .infinity, alignment: .leading)
            .bold()
            .minimumScaleFactor(0.1)
            .opacity(provider.doesNotNeedThisInfo ? 0 : 1)
    }
    
    var seeMoveButton: some View {
        Image(systemName: "chevron.right")
    }
    
    struct CellKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
        
        typealias Value = CGRect
        
    }
    
    public struct Config {
        let learningMethod: MoveLearnMethodType
        
        var methodText: String {
            switch learningMethod {
            case .levelUp:
                "Learn at level"
            case .egg, .lightBallEgg:
                "Hatched"
            case .tutor:
                "Tutor"
            case .machine:
                "Can learn with"
            case .stadiumSurphingPikachu:
                "Surphed"
            case .formChange:
                "Transformed"
            default:
                ""
            }
        }
    }
    
    @Observable
   public class Provider: Identifiable {
        
        public let id: UUID = .init()
        let moveApi: PokemonMoveApi
        let generalApi: GeneralApi<Machine>
        let config: Config
        let moveVersionData: MoveVersionMeta
        var moveItemHolder: MoveItemDataHolder?
        var machineModel: MachineModel?
        
        var isLevelUp: Bool {
            moveVersionData.learningMethod == .levelUp
        }
        
        var isMachine: Bool {
            moveVersionData.learningMethod == .machine
        }
        
        var doesNotNeedThisInfo: Bool {
            moveVersionData.learningMethod == .egg ||
            moveVersionData.learningMethod == .tutor ||
            moveVersionData.learningMethod == .formChange
        }
        
        var moveTextAtLevel: String {
            if isMachine {
                machineModel?.machineItem ?? "\(moveVersionData.levelLearntAt)"
            } else {
                "\(moveVersionData.levelLearntAt)"
            }
        }
        
        init(moveApi: PokemonMoveApi, generalApi: GeneralApi<Machine>, moveVersionData: MoveVersionMeta) {
            self.moveApi = moveApi
            self.generalApi = generalApi
            self.moveVersionData = moveVersionData
            self.config = .init(learningMethod: moveVersionData.learningMethod)
            Task {
                await fetch()
            }
        }
        
        private func fetch() async {
            let result = await moveApi.fetch(query: .init(moveId: moveVersionData.moveName))
            switch result {
            case .success(let success):
                await makeItem(for: success)
                await getMachine(for: success)
            case .failure(let failure):
                print(#file, "\n", failure)
            }
        }
        
        @MainActor
        private func makeItem(for move: Move) {
            self.moveItemHolder = MoveItemDataHolder(
                id: move.id,
                name: move.names.map { MoveNameItem(name: $0.name, language: $0.language.name) },
                effects: move.effectEntries.map { MoveEffectItem(effect: $0.shortEffect, language: $0.language.name) },
                type: move.type.name,
                damageClass: .init(rawValue: move.damageClass.name),
                generation: move.generation.name,
                drain: move.meta?.drain,
                healing: move.meta?.healing,
                critRate: move.meta?.crit_rate,
                ailmentChance: move.meta?.ailment_chance,
                flintChance: move.meta?.flinch_chance,
                statChance: move.meta?.stat_chance,
                learntBy: move.learnedByPokemon.map(\.name),
                priority: move.priority,
                pp: move.pp,
                power: move.power
                
            )
        }
        
        private func getMachine(for move: Move) async {
            guard isMachine else { return }
            guard let machine = move.machines.first(where: { VersionGroupType(rawValue: $0.versionGroup.name)! == moveVersionData.version})
            else { return }
            let result = await generalApi.fetch(query: .init(url: machine.machine.url))
            switch result {
            case .success(let success):
                await MainActor.run {
                    machineModel = .init(machineItem: success.item.name.uppercased(), moveName: success.item.name)
                }
            case .failure(let failure):
                print(#file,"\n",#function, failure)
            }
        }
    }
}

#Preview {
    
    @Environment(\.diContainer) var container
    
    return MoveViewCell(provider: .init(moveApi: .init(), generalApi: .init(), moveVersionData: .init(moveName: "double-edge", version: .yellow, levelLearntAt: 8, learningMethod: .levelUp)), width: UIScreen.main.nativeBounds.width)
        .preferredColorScheme(.dark)
        .inject(container: container)
}
