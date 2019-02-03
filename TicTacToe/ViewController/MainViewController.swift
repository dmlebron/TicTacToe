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
    @IBOutlet weak var player1IconImageView: UIImageView!
    @IBOutlet weak var player2IconImageView: UIImageView!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var playerTurnLabel: UILabel!
    private var viewModel: MainViewModelInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        for col in collection {
            col.addTarget(self, action: #selector(tapped(customView:)), for: .touchUpInside)
        }
    }

    func bindViewModel(_ input: MainViewModelInput, output: inout MainViewModelOutput) {
        self.viewModel = input
        output.player1IconImage = { [weak self] (image) in
            self?.player1IconImageView.image = image
        }
        
        output.player2IconImage = { [weak self] (image) in
            self?.player2IconImageView.image = image
        }
        
        output.playerTurnString = { [weak self] (value) in
            self?.playerTurnLabel.text = value
        }
        
        output.playCountObservable = { (value) in
            print("Play Count: \(value)")
        }
        
        output.selectedViewObservable = { [weak self] (value) in
            self?.handleSelectedView(value)
        }
    }
}

@objc extension MainViewController {
    func tapped(customView: CustomView) {
        viewModel.tapped(isSelected: customView.isSelected, viewIdentifier: customView.identifier)
    }
}

private extension MainViewController {
    func handleSelectedView(_ selectedView: MainViewModel.SelectedView?) {
        guard let selectedView = selectedView else { return }
        let view = collection
            .filter { $0.identifier == selectedView.viewIdentifier }
            .first
        view?.isSelected = selectedView.isSelected
        view?.image = selectedView.image
    }
}
