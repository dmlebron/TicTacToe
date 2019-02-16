//
//  Game.swift
//  TicTacToe
//
//  Created by David Martinez-Lebron on 2/13/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import Foundation

struct Game {
    private let player1: Player
    private let player2: Player
    var playCount: Int {
        return player1.moves.count + player2.moves.count
    }
    
    init(player1: Player, player2: Player) throws {
        guard player1.mark != player2.mark else { throw Error.sameMarks }
        self.player1 = player1
        self.player2 = player2
    }

    mutating func move(_ move: Move, turn: Player.Turn) -> Player.Turn {
        let player = playerForTurn(turn)
        player.moves.append(move)
        return nextTurn(turn)
    }

    mutating func reset() {
        player1.moves = []
        player2.moves = []
    }
    
    func evaluate(player: Player) -> String? {
        let combinations: [WinningCombination]  = [.topDiagonal, .corners, .bottomDiagonal, .firstSquare, .secondSquare, .thirdSquare, .fourthSquare, .fifthSquare, .sixthSquare, .seventhSquare, .eighthSquare, .ninethSquare]
        
        for combination in combinations {
            if combination.isWinner(playerMoves: player.moves) {
                return "\(player.description) Wins"
            }
        }
        return nil
    }
    
    static func evaluate(player: Player) -> String? {
        let combinations: [WinningCombination]  = [.topDiagonal, .corners, .bottomDiagonal, .firstSquare, .secondSquare, .thirdSquare, .fourthSquare, .fifthSquare, .sixthSquare, .seventhSquare, .eighthSquare, .ninethSquare]
        
        for combination in combinations {
            if combination.isWinner(playerMoves: player.moves) {
                return "\(player.description) Wins"
            }
        }
        return nil
    }
}

private extension Game {
    func updatePlayerMoves(viewIdentifier: Int) {
//        currentPlayer.moves.append(viewIdentifier)
    }
    
    func playerForTurn(_ turn: Player.Turn) -> Player {
        return player1.turn == turn ? player1 : player2
    }
    
    func nextTurn(_ turn: Player.Turn) -> Player.Turn {
        return player1.turn == turn ? player2.turn : player1.turn
    }
}

extension Game {
    enum Error: Swift.Error {
        case sameMarks
    }
    enum Constant {
        static let minimumLocationValue: Move = 0
        static let maxLocationValue: Move = 15
        static let maxMoves = 16
    }
    
    enum WinningCombination: Equatable {
        case topDiagonal
        case corners
        case bottomDiagonal
        case firstSquare
        case secondSquare
        case thirdSquare
        case fourthSquare
        case fifthSquare
        case sixthSquare
        case seventhSquare
        case eighthSquare
        case ninethSquare
        
        private var winningMoves: Moves {
            switch self {
            case .topDiagonal: return [0, 5, 10, 15]
            case .corners: return [0, 3, 12, 15]
            case .bottomDiagonal: return [3, 6, 9, 12]
            case .firstSquare: return [0,1,4,5]
            case .secondSquare: return [1,2,5,6]
            case .thirdSquare: return [2,3,6,7]
            case .fourthSquare: return [4,5,8,9]
            case .fifthSquare: return [5,6,9,10]
            case .sixthSquare: return [6,7,10,11]
            case .seventhSquare: return [8,9,12,13]
            case .eighthSquare: return [9,10,13,14]
            case .ninethSquare: return [10,11,14,15]
            }
        }
        
        func isWinner(playerMoves: Moves) -> Bool {
            guard playerMoves.count > 3 else { return false }
            return evaluate(playerMoves)
        }
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
