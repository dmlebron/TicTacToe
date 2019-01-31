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
    
    func viewDidLoad()
    mutating func tapped(objectData: CustomView.ObjectData?) throws -> CustomView.ObjectData
}

protocol MainViewModelOutput: class {
    
}

struct MainViewModel {
    
    enum Error: Swift.Error {
        case spaceNotAvailable
        case badData
    }
    
    weak var output: MainViewModelOutput?
    
    private(set) var player1 = Player(mark: .x)
    private(set) var player2 = Player(mark: .o)
    private(set) var playCount = 0
    
    init(output: MainViewModelOutput) {
        self.output = output
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
    func viewDidLoad() {
        
    }
    
    mutating func tapped(objectData: CustomView.ObjectData?) throws -> CustomView.ObjectData {
        try isSpaceAvailable(objectData: objectData)
        addPlayCount()
        let player = currentPlayer
        return CustomView.ObjectData(player: player, isSelected: true)
    }
}
