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
    @IBOutlet var player1IconImage: UIImageView!
    @IBOutlet var player2IconImage: UIImageView!
    @IBOutlet var player1Label: UILabel!
    @IBOutlet var player2Label: UILabel!
    
    private lazy var viewModel: MainViewModel = {
        return MainViewModel(output: self) { [weak self] (viewState) in
            guard let strongSelf = self else { return }
            switch viewState {
            case .initial(let player1, let player2):
                strongSelf.handleViewStateInitial(player1, player2)
            case .changed(let player, let playCount):
                strongSelf.handleViewStateChanged(player, playCount)
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        for col in collection {
            col.addTarget(self, action: #selector(tapped(customView:)), for: .touchUpInside)
        }
    }
    
    @objc func tapped(customView: CustomView) {
        do {
            try viewModel.tapped(objectData: customView.objectData)
        } catch {
            
        }
    }
}

private extension MainViewController {
    func handleViewStateInitial(_ player1: Player, _ player2: Player) {
        player1IconImage.image = player1.image
        player2IconImage.image = player2.image
    }
    
    func handleViewStateChanged(_ player: Player, _ playCount: Int) {
        
    }
}


// MARK: - MainViewModelOutput
extension MainViewController: MainViewModelOutput {
    
}
