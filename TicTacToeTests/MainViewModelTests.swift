//
//  MainViewModelTests.swift
//  TicTacToeTests
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import XCTest
@testable import TicTacToe

class MainViewModelTests: XCTestCase {

    var viewModel: MainViewModel!
    var mockViewController: MockMainViewController!
    var player1: Player!
    var player2: Player!
    
    override func setUp() {
        mockViewController = MockMainViewController()
        player1 = Player(mark: .x, turn: .firstPlayer)
        player2 = Player(mark: .o, turn: .secondPlayer)
        
        viewModel = try! MainViewModel(player1: player1, player2: player2)
        var output: MainViewModelOutput = viewModel
        mockViewController.bindViewModel(viewModel, output: &output)
    }
    
    func test_Init_InvalidPlayer_SameMarks() throws {
        player1 = Player(mark: .o, turn: .firstPlayer)
        player2 = Player(mark: .o, turn: .secondPlayer)
        
        XCTAssertThrowsError(try MainViewModel(player1: player1, player2: player2))
    }
    
    func test_Init_InvalidPlayer_SameTurn() throws {
        player1 = Player(mark: .o, turn: .firstPlayer)
        player2 = Player(mark: .x, turn: .firstPlayer)
        
        XCTAssertThrowsError(try MainViewModel(player1: player1, player2: player2))
    }
    
    func test_ViewDidLoad_InitialValues() {
        viewModel.viewDidLoad()
        
        XCTAssertNotNil(mockViewController.didCallPlayer1Icon)
        XCTAssertNotNil(mockViewController.didCallPlayer2Icon)
        XCTAssertFalse(mockViewController.didCallPlayer1Icon == mockViewController.didCallPlayer2Icon)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player1.turn.string)
    }
    
    func test_Tapped_ValidLocation_UpdatePlayer() {
        let viewIdentifier = 9
        viewModel.tapped(isSelected: false, viewIdentifier: viewIdentifier)
        XCTAssertTrue(player1.locations.count > 0)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player2.turn.string)
        
        let viewIdentifier2 = 0
        viewModel.tapped(isSelected: false, viewIdentifier: viewIdentifier2)
        XCTAssertTrue(player2.locations.count > 0)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player1.turn.string)
    }
    
    func test_Tapped_SelectedLocation_NotUpdatePlayer() {
        let viewIdentifier = 9
        viewModel.tapped(isSelected: false, viewIdentifier: viewIdentifier)
        XCTAssertTrue(player1.locations.count > 0)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player2.turn.string)
        
        let viewIdentifier2 = 9
        viewModel.tapped(isSelected: true, viewIdentifier: viewIdentifier2)
        XCTAssertFalse(player2.locations.count > 0)
    }
    
    func test_Tapped_InvalidLocation_LessThan0_NotUpdatePlayer() {
        let viewIdentifier = -1
        viewModel.tapped(isSelected: false, viewIdentifier: viewIdentifier)
        XCTAssertFalse(player1.locations.count > 0)
        XCTAssertFalse(mockViewController.didCallPlayerTurnString == player2.turn.string)
    }
    
    func test_Tapped_InvalidLocation_GreaterThan15_NotUpdatePlayer() {
        let viewIdentifier = 17
        viewModel.tapped(isSelected: false, viewIdentifier: viewIdentifier)
        XCTAssertFalse(player1.locations.count > 0)
        XCTAssertFalse(mockViewController.didCallPlayerTurnString == player2.turn.string)
    }
    
    func test_Tapped_GameFinished_AllMoves_NoWinner() {
        for move in 0...15 {
            viewModel.tapped(isSelected: false, viewIdentifier: move)
        }
        let gameEnded = mockViewController.didCallGameEnded!
        XCTAssertTrue(gameEnded == MainViewModel.Game.State.tie)
    }

    func test_Tapped_GameFinished_Winner_TopDiagonalCombination() {
        for move in 0...10 {
            switch move {
            case 0:
                viewModel.tapped(isSelected: false, viewIdentifier: 0)
            case 2:
                viewModel.tapped(isSelected: false, viewIdentifier: 5)
            case 4:
                viewModel.tapped(isSelected: false, viewIdentifier: 10)
            case 5:
                viewModel.tapped(isSelected: false, viewIdentifier: 2)
            case 6:
                viewModel.tapped(isSelected: false, viewIdentifier: 15)
            default:
                viewModel.tapped(isSelected: false, viewIdentifier: move)
            }
        }
        
        let gameEnded = mockViewController.didCallGameEnded
        XCTAssertTrue(gameEnded == MainViewModel.Game.State.winner(.topDiagonal, player1))
    }
    
//    func test_Turn_PairValue_Player2() throws {
//        // first turn
//        _ = try viewModel.tapped(objectData: nil)
//        // second turn
//        let object = try viewModel.tapped(objectData: nil)
//        XCTAssertTrue(viewModel.playCount == 2)
//        XCTAssertTrue(object.player == viewModel.player2)
//    }
//
//    func test_Turn_PairValue_Player2_SpaceAvailable() throws {
//        let player = Player(mark: .x, turn: .first)
//        let data = CustomView.ObjectData(player: player, isSelected: false)
//        // first turn
//        _ = try viewModel.tapped(objectData: data)
//        // second turn
//        let object = try viewModel.tapped(objectData: data)
//        XCTAssertTrue(viewModel.playCount == 2)
//        XCTAssertTrue(object.player == viewModel.player2)
//    }
//
//    func test_Turn_PairValue_Player2_SpaceNotAvailable() throws {
//        // first turn
//        let object = try viewModel.tapped(objectData: nil)
//        // second turn
//        XCTAssertThrowsError(try viewModel.tapped(objectData: object))
//        XCTAssertTrue(viewModel.playCount == 1)
//        XCTAssertTrue(object.player == viewModel.player1)
//    }
//
//    func test_Turn_PairValue_Player1_SpaceNotAvailable() throws {
//        // first turn
//        let object = try viewModel.tapped(objectData: nil)
//        // second turn
//        _ = try viewModel.tapped(objectData: nil)
//        // third turn
//        XCTAssertThrowsError(try viewModel.tapped(objectData: object))
//        XCTAssertTrue(viewModel.playCount == 2)
//        XCTAssertTrue(object.player == viewModel.player1)
//    }
//
//    func test_NextPlayer_FirstTurn_Player1() {
//        let playerTurn = viewModel.nextPlayer
//        let playCount = viewModel.playCount
//
//        XCTAssertTrue(playCount == 0)
//        XCTAssertTrue(playerTurn == viewModel.player1)
//    }
//
//    func test_NextPlayer_SecondTurn_Player2() throws {
//        _ = try viewModel.tapped(objectData: nil)
//        let playerTurn = viewModel.nextPlayer
//        let playCount = viewModel.playCount
//
//        XCTAssertTrue(playCount == 1)
//        XCTAssertTrue(playerTurn == viewModel.player2)
//    }
}
