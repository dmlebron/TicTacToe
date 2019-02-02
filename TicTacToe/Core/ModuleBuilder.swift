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
        
        let viewModel = MainViewModel(output: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
