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
        XCTAssertNil(mockViewController.didCallErrorObservable)
    }
    
    func test_Tapped_ValidLocation_UpdatePlayer() {
        let viewIdentifier = 9
        viewModel.tapped(viewIdentifier: viewIdentifier)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player2.turn.string)
        XCTAssertTrue(player1.moves.count == 1)
        XCTAssertNotNil(mockViewController.didCallSelectedView?.image == player1.image)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player2.turn.string)
        
        let viewIdentifier2 = 0
        viewModel.tapped(viewIdentifier: viewIdentifier2)
        XCTAssertTrue(player2.moves.count > 0)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player1.turn.string)
        XCTAssertNil(mockViewController.didCallErrorObservable)
    }
    
    func test_Tapped_SelectedLocation_NotUpdatePlayer() {
        let viewIdentifier = 9
        viewModel.tapped(viewIdentifier: viewIdentifier)
        XCTAssertTrue(player1.moves.count > 0)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == player2.turn.string)
        
        let viewIdentifier2 = 9
        viewModel.tapped(viewIdentifier: viewIdentifier2)
        XCTAssertFalse(player2.moves.count > 0)
        XCTAssertTrue(mockViewController.didCallErrorObservable?.localizedDescription == MainViewModel.Error.locationNotAvailable.localizedDescription)
    }
    
    func test_Tapped_InvalidLocation_LessThan0_NotUpdatePlayer() {
        let viewIdentifier = -1
        viewModel.tapped(viewIdentifier: viewIdentifier)
        XCTAssertFalse(player1.moves.count > 0)
        XCTAssertFalse(mockViewController.didCallPlayerTurnString == player2.turn.string)
        XCTAssertTrue(mockViewController.didCallErrorObservable?.localizedDescription == MainViewModel.Error.notValidLocation.localizedDescription)
    }
    
    func test_Tapped_InvalidLocation_GreaterThan15_NotUpdatePlayer() {
        let viewIdentifier = 17
        viewModel.tapped(viewIdentifier: viewIdentifier)
        XCTAssertFalse(player1.moves.count > 0)
        XCTAssertFalse(mockViewController.didCallPlayerTurnString == player2.turn.string)
        XCTAssertTrue(mockViewController.didCallErrorObservable?.localizedDescription == MainViewModel.Error.notValidLocation.localizedDescription)
    }
    
    func test_Tapped_GameFinished_AllMoves_NoWinner() {
        for move in 0...Game.Constant.maxMoves - 1 {
            viewModel.tapped(viewIdentifier: move)
        }
        let gameStatus = mockViewController.didCallGameStatus!
        
        XCTAssertTrue(player1.moves.count == 8)
        XCTAssertTrue(player2.moves.count == 8)
        XCTAssertNil(mockViewController.didCallErrorObservable)
        XCTAssertTrue(gameStatus == MainViewModel.GameStatus.ended(MainViewModel.Result.tie))
        
    }

    func test_Tapped_GameFinished_Winner_TopDiagonalCombination() {
        for move in 0...10 {
            switch move {
            case 0:
                viewModel.tapped(viewIdentifier: 15)
            case 2:
                viewModel.tapped(viewIdentifier: 5)
            case 4:
                viewModel.tapped(viewIdentifier: 10)
            case 5:
                viewModel.tapped(viewIdentifier: 2)
            case 6:
                viewModel.tapped(viewIdentifier: 0)
            default:
                viewModel.tapped(viewIdentifier: move)
            }
        }
        
        let gameStatus = mockViewController.didCallGameStatus
        XCTAssertTrue(gameStatus == MainViewModel.GameStatus.ended(.winner("First Player Wins")))
    }
    
    func test_Reset_Clean() {
        for move in 0...15 {
            viewModel.tapped(viewIdentifier: move)
        }
        
        XCTAssertTrue(player1.moves.count > 0)
        XCTAssertTrue(player2.moves.count > 0)
        
        viewModel.tappedReset()
        let gameStatus = mockViewController.didCallGameStatus
        XCTAssertTrue(gameStatus == MainViewModel.GameStatus.reset)
        XCTAssertTrue(player1.moves.count == 0)
        XCTAssertTrue(player2.moves.count == 0)
    }
}
