//
//  MockMainViewController.swift
//  TicTacToeTests
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit
@testable import TicTacToe

class MockMainViewController {
    
    var viewModel: MainViewModelInput!
    
    var didCallPlayer1Icon: UIImage?
    var didCallPlayer2Icon: UIImage?
    var didCallPlayerTurnString: String?
    var didCallPlayCount: Int?
    var didCallSelectedView: MainViewModel.SelectedView?
    func bindViewModel(_ viewModel: MainViewModelInput, output: inout MainViewModelOutput) {
        self.viewModel = viewModel
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
