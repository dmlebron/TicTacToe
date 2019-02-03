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
    
    var playerTurnString: String?
    var playCount: Int?
    var player1IconImage: UIImage?
    var player2IconImage: UIImage?
    var error: Error?
    var selectedView: MainViewModel.SelectedView?
    
    
}
