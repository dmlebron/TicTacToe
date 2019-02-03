//
//  MockMainViewController.swift
//  TicTacToeTests
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit
@testable import TicTacToe

class MockMainViewController: MainViewModelOutput {
    var viewModel: MainViewModelInput!
    
    var playerTurnString: ((String) -> Void)!
    var player1IconImage: ((UIImage) -> Void)!
    var player2IconImage: ((UIImage) -> Void)!
    var playCount: ((Int) -> Void)!
    var error: ((Error) -> Void)!
    var selectedView: MainViewModel.SelectedView?
    
    var didCallPlayer1Icon: UIImage?
    var didCallPlayer2Icon: UIImage?
    var didCallPlayerTurnString: String?
    var didCallPlayCount: Int?
    func bindViewModel() {
        player1IconImage = { (image) in
            self.didCallPlayer1Icon = image
        }
        
        player2IconImage = { (image) in
            self.didCallPlayer2Icon = image
        }
        
        playerTurnString = { (value) in
            self.didCallPlayerTurnString = value
        }
        
        playCount = { (value) in
            self.didCallPlayCount = value
        }
        
        error = { (value) in
            print("Error: \(value)")
        }
    }
}
