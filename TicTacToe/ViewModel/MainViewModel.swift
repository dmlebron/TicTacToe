//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

protocol MainViewModelInput {
    mutating func viewDidLoad()
    mutating func tapped(isSelected: Bool, viewIdentifier: Int)
}

protocol MainViewModelOutput: class {
    var playerTurnString: String { get set }
    var playCount: Int { get set }
    var player1IconImage: UIImage { get set }
    var player2IconImage: UIImage { get set }
    var error: Error? { get set }
    var selectedView: MainViewModel.SelectedView? { get set }
}

struct MainViewModel {
    
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
    
    weak var output: MainViewModelOutput?
    
    private var player1 = Player(mark: .x, turn: .firstPlayer)
    private var player2 = Player(mark: .o, turn: .secondPlayer)
    private var currentPlayer: Player? {
        didSet {
            guard let currentPlayer = currentPlayer else { return }
            output?.playerTurnString = currentPlayer.turn.string
        }
    }
    private var playCount = 0 {
        didSet {
            output?.playCount = playCount
        }
    }
    
    init(output: MainViewModelOutput) {
        self.output = output
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    func isLocationSelected(_ isSelected: Bool) throws {
        if isSelected {
            throw Error.spaceNotAvailable
        }
    }
    
    mutating func logPlay(viewIdentifier: Int) {
        playCount += 1
        output?.selectedView = SelectedView(viewIdentifier: viewIdentifier,
                                                  image: currentPlayer?.image,
                                                  isSelected: true)
        currentPlayer = togglePlayerTurn()
    }
    
    mutating func togglePlayerTurn() -> Player {
        return currentPlayer == player1 ? player2 : player1
    }
    
    mutating func reset() {
        output?.player1IconImage = player1.image
        output?.player2IconImage = player2.image
        playCount = 0
        currentPlayer = player1
    }
}

// MARK: - MainViewModelInput
extension MainViewModel: MainViewModelInput {
    mutating func viewDidLoad() {
        reset()
    }
    
    mutating func tapped(isSelected: Bool, viewIdentifier: Int) {
        do {
            try isLocationSelected(isSelected)
            logPlay(viewIdentifier: viewIdentifier)
            
        } catch {
            output?.error = error
        }
    }
}
