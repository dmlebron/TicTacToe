//
//  MockMainViewController.swift
//  TicTacToeTests
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit
@testable import TicTacToe

class MockMainViewController: MainViewModelOutputObserver {
    
    var viewModel: MainViewModelInput!
    
    var didCallPlayer1Icon: UIImage?
    var didCallPlayer2Icon: UIImage?
    var didCallPlayerTurnString: String?
    var didCallPlayCount: Int?
    var didCallSelectedView: MainViewModel.SelectedView?
    var didCallGameEnded: MainViewModel.Game.State?
    var didCallResetAllLocations: Bool?
    var didCallErrorObservable: MainViewModel.Error?
    func bindViewModel(_ input: MainViewModelInput, output: inout MainViewModelOutput) {
        self.viewModel = input
        output.player1IconObservable = { (image) in
            self.didCallPlayer1Icon = image
        }
        
        output.player2IconObservable = { (image) in
            self.didCallPlayer2Icon = image
        }
        
        output.playerTurnObservable = { (value) in
            self.didCallPlayerTurnString = value
        }
        
        output.playCountObservable = { (value) in
            self.didCallPlayCount = value
        }
        
        output.selectedViewObservable = { (value) in
            self.didCallSelectedView = value
        }
        
        output.showGameStateObservable = { (value) in
            switch value {
            case .tie, .winner(_, _):
                self.didCallGameEnded = value

            case .reset:
                self.didCallResetAllLocations = true
                
            }
        }
        
        output.errorObservable = { (value) in
            self.didCallErrorObservable = value
        }
    }
}
