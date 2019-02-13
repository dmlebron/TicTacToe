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
}
