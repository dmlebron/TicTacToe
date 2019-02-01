//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import Foundation

protocol MainViewModelInput {
    var output: MainViewModelOutput? { get }
    
    mutating func viewDidLoad()
    mutating func tapped(objectData: CustomView.ObjectData?) throws -> CustomView.ObjectData
}

protocol MainViewModelOutput: class {
    
}

struct MainViewModel {
    
    enum Error: Swift.Error {
        case spaceNotAvailable
        case badData
    }
    
    enum ViewState {
        case initial(player1: Player, player2: Player)
        case changed(playerTurn: Player, playCount: Int)
    }
    
    weak var output: MainViewModelOutput?
    
    private(set) var player1 = Player(mark: .x, turn: .first)
    private(set) var player2 = Player(mark: .o, turn: .second)
    private var playCount = 0
    private var viewStateCompletion: (ViewState) -> Void
    private var state: ViewState? {
        didSet {
            guard let state = state else { return }
            viewStateCompletion(state)
        }
    }
    
    init(output: MainViewModelOutput, completion: @escaping (ViewState) -> Void) {
        self.output = output
        self.viewStateCompletion = completion
    }
    
    var currentPlayer: Player {
        return playCount % 2 == 0 ? player2 : player1
    }
    
    var nextPlayer: Player {
        return playCount % 2 != 0 ? player2 : player1
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    func isSpaceAvailable(objectData: CustomView.ObjectData?) throws {
        guard let objectData = objectData else { return }
        if objectData.isSelected {
            throw Error.spaceNotAvailable
        }
    }
    
    mutating func addPlayCount() {
        playCount += 1
    }
}

// MARK: - MainViewModelInput
extension MainViewModel: MainViewModelInput {
    mutating func viewDidLoad() {
        state = .initial(player1: player1, player2: player2)
    }
    
    mutating func tapped(objectData: CustomView.ObjectData?) throws -> CustomView.ObjectData {
        try isSpaceAvailable(objectData: objectData)
        addPlayCount()
        let player = currentPlayer
        return CustomView.ObjectData(player: player, isSelected: true)
    }
}
