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
    
    func bindViewModel() {
        player1IconImage = { (image) in
//            self?.player1IconImageView.image = image
        }
        
        player2IconImage = { (image) in
//            self?.player2IconImageView.image = image
        }
        
        playerTurnString = { (value) in
//            self?.playerTurnLabel.text = value
        }
        
        playCount = { (value) in
            print("Play Count: \(value)")
        }
        
        error = { (value) in
            print("Error: \(value)")
        }
    }
}
