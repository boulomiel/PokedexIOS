//
//  PokemonMoveListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 25/04/2024.
//

import SwiftUI
import SwiftData
import Resources
import Tools
import DI
import Dtos

public struct PokemonSelectionMoveListScreen: View {
    
    @Environment(TeamRouter.self) var teamRouter
    @State var provider: Provider
    @State private var remindMoveItem: RemindMovesItem?
    @Namespace var loading
    public var body: some View {
        List(provider.moves) { move in
            ListMoveCellView(move: move, isSelectable: true, provider: provider)
        }
        .navigationTitle("Moves Selection")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(provider.selectionActive ? "Cancel" : "Select") {
                        provider.handleSelection()
                    }
                    
                    if provider.selectedMoves.count == 4 {
                        Button("Save") {
                            remindMoveItem = .init()
                        }
                    }
                }
            }
        }
        .blur(radius: remindMoveItem != nil ? 1.0 : 0)
        .sheet(item: $remindMoveItem, onDismiss: {
            remindMoveItem = nil
        }, content: { _ in
            saveMoveSheet
        })
        .loadable(isLoading: provider.moves.isEmpty)
        
    }
    
    var saveMoveSheet: some View {
        VStack {
            Text("These are the move you have selected:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            ForEach(provider.selectedMoves) { move in
                ListMoveCellView(move: move, isSelectable: false, provider: provider)
            }
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(Color.gray.opacity(0.1)))
            
            HStack {
                Button("Cancel") {
                    remindMoveItem = nil
                }
                
                Spacer()
                
                Button("Save") {
                    provider.saveMoves()
                    remindMoveItem = nil
                    teamRouter.back()
                }
                .contentShape(RoundedRectangle(cornerRadius: 2))
                .padding()
            }
        }
        .padding(.horizontal)
        .presentationDetents([.height(340)])
    }
    
    public struct RemindMovesItem: Identifiable {
        public let id: UUID = .init()
    }
    
    @Observable
   public class Provider {
        let movesAPI: PokemonMoveApi
        let movesURL: [URL]
        var selectedMoves: [Move]
        var moves: [Move]
        var selectionActive: Bool
        var pokemonID: PersistentIdentifier
        var modelContext: ModelContext
        
        init(movesAPI: PokemonMoveApi, movesURL: [URL], selectedMoves: [Move] = [], pokemonID: PersistentIdentifier, modelContext: ModelContext) {
            self.movesAPI = movesAPI
            self.movesURL = movesURL
            self.selectedMoves = selectedMoves
            self.moves = []
            self.selectionActive = !selectedMoves.isEmpty
            self.pokemonID = pokemonID
            self.modelContext = modelContext
            Task {
                await fetch()
            }
            self.selectedMoves.reserveCapacity(4)
        }
        
        func fetch() async {

            let moves = await withTaskGroup(of: Move?.self) { group in
                self.movesURL.forEach { url in
                    group.addTask {
                        let result = await self.movesAPI.fetch(query: .init(moveId: url.lastPathComponent))
                        switch result {
                        case .success(let success):
                            return success
                        case .failure(let failure):
                            print(#file, failure)
                            return nil
                        }
                    }
                }
                var result: [Move] = []
                for await move in group {
                    if let move {
                        result.append(move)
                    }
                }
                return result
            }
            let sorted = moves.sorted(by: { $0.power ?? 0 < $1.power ?? 0 })
            await MainActor.run {
                withAnimation(.snappy) {
                    self.moves = sorted
                }
            }
        }
        
        func isSelected(move: Move) -> Bool {
           selectedMoves.contains(move)
        }
        
        func selectMove(_ move: Move) -> Bool {
            Vibrator.selection()
            return withAnimation {
                if isSelected(move: move) {
                    selectedMoves.removeAll(where: { $0 == move })
                    return false
                } else {
                    if selectedMoves.count < 4 {
                        selectedMoves.append(move)
                        return true
                    }
                    return false
                }
            }
        }
        
        func handleSelection() {
            if selectionActive {
                Vibrator.change(of: .soft)
                withAnimation {
                    selectionActive = false
                    cleanSelection()
                }
            } else {
                Vibrator.change(of: .light)
                withAnimation {
                    selectionActive = true
                }
            }            
        }
        
        func cleanSelection() {
            selectedMoves = []
        }
        
        func saveMoves() {
            let pokemon = modelContext.fetchUniqueSync(SDPokemon.self, with: pokemonID)
            pokemon?.moves = selectedMoves.map { SDMove(moveID: $0.id, data: try? JSONEncoder().encode($0)) }
            try? modelContext.save()
            Vibrator.notify(of: .success)
        }
    }
}




#Preview {
    @Environment(\.diContainer) var container
    let pikachu: Pokemon = JsonReader.read(for: .pikachu)
    let preview = Preview(SDPokemon.self, SDMove.self, SDItem.self, SDTeam.self)
    let sdPikachu = SDPokemon(pokemonID: pikachu.id, data: try? JSONEncoder().encode(pikachu))
    preview.addExamples([sdPikachu])
    return NavigationStack {
        PokemonSelectionMoveListScreen(provider: .init(movesAPI: .init(), movesURL: pikachu.moves.map(\.move.url), pokemonID: sdPikachu.id, modelContext: preview.container.mainContext))
    }
    .environment(TeamRouter())
    .inject(container: container)
    .preferredColorScheme(.dark)
}


extension Array {
    
    func chunked(by number: Int) -> [Self] {
        var result: [Self] = []
        result.reserveCapacity((count+number-1)/number)
        var currentIndex = 0
        while currentIndex < count {
            result.append(Array(self[currentIndex..<endIndex]))
            currentIndex = endIndex
        }
        return result
    }
    
    func chunkedStream(by number: Int) -> AsyncStream<Self> {
        AsyncStream { continuation in
            var chunks = chunked(by: number)
            while !chunks.isEmpty {
                continuation.yield(chunks.removeFirst())
            }
            continuation.finish()
        }
    }
}
