//
//  Game.swift
//  TicTacToe
//
//  Created by David Martinez-Lebron on 2/13/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import Foundation

struct Game {
    enum Constant {
        static let minimumLocationValue: Move = 0
        static let maxLocationValue: Move = 15
        static let maxMoves = 16
    }
    
    enum WinningCombination: Equatable {
        case topDiagonal
        case corners
        case bottomDiagonal
        
        private var winningMoves: Moves {
            switch self {
            case .topDiagonal: return [0, 5, 10, 15]
            case .corners: return [0, 3, 12, 15]
            case .bottomDiagonal: return [3, 6, 9, 12]
            }
        }
        
        func isWinner(playerMoves: Moves) -> Bool {
            guard playerMoves.count > 3 else { return false }
            switch self {
            case .topDiagonal:
                return evaluate(playerMoves)
            case .corners:
                return evaluate(playerMoves)
            case .bottomDiagonal:
                return evaluate(playerMoves)
            }
        }
    }
    
    static func evaluate(player: Player) -> String? {
        let combinations: [WinningCombination]  = [.topDiagonal, .corners, .bottomDiagonal]
        
        for combination in combinations {
            if combination.isWinner(playerMoves: player.moves) {
                return "\(player.description) Wins"
            }
        }
        return nil
    }
}

private extension Game.WinningCombination {
    
    func evaluate(_ playerMoves: Moves) -> Bool {
        for move in winningMoves where !playerMoves.contains(move) {
            return false
        }
        return true
    }
    
    func evaluateTopDiagonal(_ playerMoves: Moves) -> Bool {
        for move in winningMoves where !playerMoves.contains(move) {
            return false
        }
        return true
    }
    
    func evaluateCorners(_ playerMoves: Moves) -> Bool {
        for move in winningMoves where !playerMoves.contains(move) {
            return false
        }
        return true
    }
    
    func evaluateBottomDiagonal(_ playerMoves: Moves) -> Bool {
        for move in winningMoves where !playerMoves.contains(move) {
            return false
        }
        return true
    }
}
