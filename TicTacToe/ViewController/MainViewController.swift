//
//  MainViewController.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewModelOutput {

    // TODO: rename
    @IBOutlet var collection: [CustomView]!
    @IBOutlet var player1IconImageView: UIImageView!
    @IBOutlet var player2IconImageView: UIImageView!
    @IBOutlet var player1Label: UILabel!
    @IBOutlet var player2Label: UILabel!
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    var viewModel: MainViewModelInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        for col in collection {
            col.addTarget(self, action: #selector(tapped(customView:)), for: .touchUpInside)
        }
    }
    
    var playerTurnString: ((String) -> Void)!
    var player1IconImage: ((UIImage) -> Void)!
    var player2IconImage: ((UIImage) -> Void)!

    var playCount: Int = 0 {
        didSet {
            print("Play Count is Now: \(playCount)")
        }
    }
    
    var error: Error? {
        didSet {
            print(error?.localizedDescription ?? "Nada")
        }
    }
    
    var selectedView: MainViewModel.SelectedView? {
        didSet {
            guard let selectedView = selectedView else { return }
            let view = collection
                .filter { $0.identifier == selectedView.viewIdentifier }
                .first
            view?.isSelected = selectedView.isSelected
            view?.image = selectedView.image
        }
    }

    func bindViewModel() {
        player1IconImage = { [weak self] (image) in
            self?.player1IconImageView.image = image
        }
        
        player2IconImage = { [weak self] (image) in
            self?.player2IconImageView.image = image
        }
        
        playerTurnString = { [weak self] (value) in
            self?.playerTurnLabel.text = value
        }
    }
}

@objc extension MainViewController {
    func tapped(customView: CustomView) {
        viewModel.tapped(isSelected: customView.isSelected, viewIdentifier: customView.identifier)
    }
}

private extension MainViewController {
    func handleViewStateChanged(_ player: Player, _ playCount: Int, view: CustomView) {
        let object = CustomView.ObjectData(player: player, isSelected: true)
        view.setup(objectData: object)
    }
    

}
