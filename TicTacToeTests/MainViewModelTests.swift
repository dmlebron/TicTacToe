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
    
    override func setUp() {
        mockViewController = MockMainViewController()
        viewModel = MainViewModel(output: mockViewController)
        mockViewController.bindViewModel()
    }
    
    func test_ViewDidLoad_InitialValues() {
        viewModel.viewDidLoad()
        let playerString = Player(mark: .o, turn: .firstPlayer).turn.string
        
        XCTAssertNotNil(mockViewController.didCallPlayer1Icon)
        XCTAssertNotNil(mockViewController.didCallPlayer2Icon)
        XCTAssertFalse(mockViewController.didCallPlayer1Icon == mockViewController.didCallPlayer2Icon)
        XCTAssertTrue(mockViewController.didCallPlayerTurnString == playerString)
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
