//
//  MainViewController.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // TODO: rename
    @IBOutlet var collection: [CustomView]!
    private lazy var viewModel: MainViewModel = {
        return MainViewModel(output: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for col in collection {
            col.addTarget(self, action: #selector(tapped(customView:)), for: .touchUpInside)
        }
    }
    
    @objc func tapped(customView: CustomView) {
        do {
            let objectData = try viewModel.tapped(objectData: customView.objectData)
            customView.setup(objectData: objectData)
        } catch {
            
        }
    }
}


// MARK: - MainViewModelOutput
extension MainViewController: MainViewModelOutput {
    
}
