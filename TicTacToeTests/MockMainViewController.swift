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
    func bindViewModel(_ input: MainViewModelInput, output: inout MainViewModelOutput) {
        self.viewModel = input
        output.player1IconImage = { (image) in
            self.didCallPlayer1Icon = image
        }
        
        output.player2IconImage = { (image) in
            self.didCallPlayer2Icon = image
        }
        
        output.playerTurnString = { (value) in
            self.didCallPlayerTurnString = value
        }
        
        output.playCountObservable = { (value) in
            self.didCallPlayCount = value
        }
        
        output.selectedViewObservable = { (value) in
            self.didCallSelectedView = value
        }
    }
}
