//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by David Martinez-Lebron on 2/13/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    func test_Init_SameMarks_Throws() throws {
        let player1 = Player(mark: .o, turn: .firstPlayer)
        let player2 = Player(mark: .o, turn: .secondPlayer)
        
        XCTAssertThrowsError(try Game(player1: player1, player2: player2))
    }
    
    func test_Init_NoThrow() throws {
        let player1 = Player(mark: .o, turn: .firstPlayer)
        let player2 = Player(mark: .x, turn: .secondPlayer)
        
        let game = try Game(player1: player1, player2: player2)
        XCTAssertTrue(game.playCount == 0)
        XCTAssertTrue(player1.moves.count == 0)
        XCTAssertTrue(player2.moves.count == 0)
    }
    
    func test_Move_Player1_LogsMove() throws {
        let player1 = Player(mark: .o, turn: .firstPlayer)
        let player2 = Player(mark: .x, turn: .secondPlayer)
        var game = try Game(player1: player1, player2: player2)
        let nextTurn = game.move(0, turn: .firstPlayer)
        
        XCTAssertTrue(game.playCount == 1)
        XCTAssertTrue(player1.moves.count == 1)
        XCTAssertTrue(nextTurn == .secondPlayer)
    }
    
    func test_Move_Player2_LogsMove() throws {
        let player1 = Player(mark: .o, turn: .firstPlayer)
        let player2 = Player(mark: .x, turn: .secondPlayer)
        var game = try Game(player1: player1, player2: player2)
        let nextTurn = game.move(0, turn: .secondPlayer)
        
        XCTAssertTrue(game.playCount == 1)
        XCTAssertTrue(player2.moves.count == 1)
        XCTAssertTrue(nextTurn == .firstPlayer)
    }
    
    func test_Reset() throws {
        let player1 = Player(mark: .o, turn: .firstPlayer)
        let player2 = Player(mark: .x, turn: .secondPlayer)
        var game = try Game(player1: player1, player2: player2)
        _ = game.move(0, turn: .firstPlayer)
        game.reset()
        
        XCTAssertTrue(game.playCount == 0)
        XCTAssertTrue(player1.moves.count == 0)
    }
    
//    func test_Move_MaxMoves() throws {
//        let player1 = Player(mark: .o, turn: .firstPlayer)
//        let player2 = Player(mark: .x, turn: .secondPlayer)
//
//        var game = try Game(player1: player1, player2: player2)
//        game.move(0, turn: .secondPlayer)
//        XCTAssertTrue(game.playCount == 1)
//        XCTAssertTrue(player2.moves.count == 1)
//    }
    
    func test_WinningCombination_TopDiagonal_Win() {
        let winningCombination = Game.WinningCombination.topDiagonal
        let moves = [2,4,3,7,8,10,0,15,5]
        XCTAssertTrue(winningCombination.isWinner(playerMoves: moves))
    }
    
    func test_WinningCombination_TopDiagonal_NoWin() {
        let winningCombination = Game.WinningCombination.topDiagonal
        let moves = [2,4,3,7,8,10,0,15]
        XCTAssertFalse(winningCombination.isWinner(playerMoves: moves))
    }
    
    func test_WinningCombination_Corners_Win() {
        let winningCombination = Game.WinningCombination.corners
        let moves = [12,4,3,7,8,10,0,15,5]
        XCTAssertTrue(winningCombination.isWinner(playerMoves: moves))
    }
    
    func test_WinningCombination_Corners_NoWin() {
        let winningCombination = Game.WinningCombination.corners
        let moves = [4,3,7,8,10,0,15,5]
        XCTAssertFalse(winningCombination.isWinner(playerMoves: moves))
    }
    
    func test_WinningCombination_BottomDiagonal_Win() {
        let winningCombination = Game.WinningCombination.bottomDiagonal
        let moves = [3,8,5,6,3,7,8,12,9]
        XCTAssertTrue(winningCombination.isWinner(playerMoves: moves))
    }
    
    func test_Game_Evaluate_FirstPlayer_Win() {
        let player = Player(mark: .x, turn: .firstPlayer)
        let moves = [3,8,5,6,3,7,8,12,9]
        player.moves = moves
        let resultString = Game.evaluate(player: player)
        
        XCTAssertTrue(resultString == "First Player Wins")
    }
    
    func test_Game_Evaluate_SecondPlayer_Win() {
        let player = Player(mark: .x, turn: .secondPlayer)
        let moves = [3,8,5,6,3,7,8,12,9]
        player.moves = moves
        let resultString = Game.evaluate(player: player)
        
        XCTAssertTrue(resultString == "Second Player Wins")
    }
    
    func test_WinningCombination_FirstSquare_Win() {
        let winningCombination = Game.WinningCombination.firstSquare
        let moves = [0,1,3,7,4,5,9]
        
        XCTAssertTrue(winningCombination.isWinner(playerMoves: moves))
    }
    
    func test_WinningCombination_FifthSquare_Win() {
        let winningCombination = Game.WinningCombination.fifthSquare
        let moves = [10,6,3,7,4,5,9]
        
        XCTAssertTrue(winningCombination.isWinner(playerMoves: moves))
    }
}
