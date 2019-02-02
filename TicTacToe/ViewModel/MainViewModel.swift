//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

protocol MainViewModelInput {
    var output: MainViewModelOutput? { get }
    
    mutating func viewDidLoad()
    mutating func tapped(objectData: CustomView.ObjectData?, customView: CustomView?) throws
}

protocol MainViewModelOutput: class {
//    func turn(player: String)
//    func playCount(_ playCount: Int)
//    func icon(player1: Player, player2: Player)
}

struct MainViewModel {
    
    enum Error: Swift.Error {
        case spaceNotAvailable
        case noSpaceSelected
        case badData
    }
    
    enum ViewState {
        case initial(player1: Player, player2: Player)
        case changed(playerTurn: Player, playCount: Int, customView: CustomView)
    }
    
    weak var output: MainViewModelOutput?
    
    private(set) var player1 = Player(mark: .x, turn: .firstPlayer)
    private(set) var player2 = Player(mark: .o, turn: .secondPlayer)
    private var playCount = 0
    private var viewStateCompletion: (ViewState) -> Void
    private var viewState: ViewState? {
        didSet {
            guard let viewState = viewState else { return }
            viewStateCompletion(viewState)
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
        viewState = .initial(player1: player1, player2: player2)
    }
    
    mutating func tapped(objectData: CustomView.ObjectData?, customView: CustomView?) throws {
        try isSpaceAvailable(objectData: objectData)
        guard let customView = customView else { throw Error.noSpaceSelected }
        addPlayCount()
        let player = currentPlayer
        viewState = ViewState.changed(playerTurn: player, playCount: playCount, customView: customView)
    }
}
