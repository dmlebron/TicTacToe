//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

protocol MainViewModelInput {
    func viewDidLoad()
    func tapped(isSelected: Bool, viewIdentifier: Int)
}

protocol MainViewModelOutput: class {
    var playerTurnString: ((String) -> Void)? { get set }
    var player1IconImage: ((UIImage) -> Void)? { get set }
    var player2IconImage: ((UIImage) -> Void)? { get set }
    var playCountObservable: ((Int) -> Void)? { get set }
    var errorObservable: ((Swift.Error) -> Void)? { get set }
    var selectedViewObservable: ((MainViewModel.SelectedView?) -> Void)? { get set }
}

final class MainViewModel: MainViewModelOutput {
    var playerTurnString: ((String) -> Void)?
    var player1IconImage: ((UIImage) -> Void)?
    var player2IconImage: ((UIImage) -> Void)?
    var errorObservable: ((Swift.Error) -> Void)?
    var playCountObservable: ((Int) -> Void)?
    var selectedViewObservable: ((MainViewModel.SelectedView?) -> Void)?
    
    enum Error: Swift.Error {
        case spaceNotAvailable
        case noSpaceSelected
        case badData
    }
    
    struct SelectedView {
        let viewIdentifier: Int
        let image: UIImage?
        let isSelected: Bool
    }
    
    var output: MainViewModelOutput {
        return self
    }
    
    private var player1 = Player(mark: .x, turn: .firstPlayer)
    private var player2 = Player(mark: .o, turn: .secondPlayer)
    private var currentPlayer: Player? {
        didSet {
            guard let currentPlayer = currentPlayer else { return }
            output.playerTurnString?(currentPlayer.turn.string)
        }
    }
    private var playCount = 0 {
        didSet {
            output.playCountObservable?(playCount)
        }
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    func isLocationSelected(_ isSelected: Bool) throws {
        if isSelected {
            throw Error.spaceNotAvailable
        }
    }
    
    func logPlay(viewIdentifier: Int) {
        playCount += 1
        let selectedView = SelectedView(viewIdentifier: viewIdentifier,
                                        image: currentPlayer?.image,
                                        isSelected: true)
        output.selectedViewObservable?(selectedView)
        currentPlayer = togglePlayerTurn()
    }
    
    func togglePlayerTurn() -> Player {
        return currentPlayer == player1 ? player2 : player1
    }
    
    func reset() {
        output.player1IconImage?(player1.image)
        output.player2IconImage?(player2.image)
        playCount = 0
        currentPlayer = player1
    }
}

// MARK: - MainViewModelInput
extension MainViewModel: MainViewModelInput {
    func viewDidLoad() {
        reset()
    }
    
    func tapped(isSelected: Bool, viewIdentifier: Int) {
        do {
            try isLocationSelected(isSelected)
            logPlay(viewIdentifier: viewIdentifier)
            
        } catch {
            output.errorObservable?(error)
        }
    }
}
