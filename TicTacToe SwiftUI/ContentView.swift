//
//  ContentView.swift
//  TicTacToe SwiftUI
//
//  Created by Mauricio Fontana on 28/02/23.
//

import SwiftUI

struct ContentView: View {

    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = true
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.teal).opacity(
                                    moves[i] == nil ? 0.3 : 0.7
                                )
                                .frame(
                                    width: geometry.size.width / 3 - 16
                                )
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) || !isHumansTurn { return }
                            moves[i] = Move(player: .human, boardIndex: i)
                            
                            isHumansTurn.toggle()
                            
                            if isBoardFilled(in: moves) { return }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerPosition = determineComputerMovePosition(in: moves)
                                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                isHumansTurn.toggle()
                            }
                        }
                    }
                }
                .padding(.all, 16)
                Spacer()
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func isBoardFilled(in moves: [Move?]) -> Bool {
        return moves.allSatisfy({$0 != nil})
    }
    
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
