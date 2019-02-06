//
//  ModuleBuilder.swift
//  TicTacToe
//
//  Created by david martinez on 2/2/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

struct ModuleBuilder {
    static func MainModule() -> MainViewController {
        let viewController = UIStoryboard.main.instantiateInitialViewController() as! MainViewController
        let player1 = Player(mark: .x, turn: .firstPlayer)
        let player2 = Player(mark: .o, turn: .secondPlayer)
        let viewModel = try! MainViewModel(player1: player1, player2: player2)
        var output: MainViewModelOutput = viewModel
        viewController.bindViewModel(viewModel, output: &output)
        
        return viewController
    }
}
