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
    // TODO: Remove isSelected
    func tapped(viewIdentifier: Int)
    func tappedReset()
}

protocol MainViewModelOutput: class {
    var playerTurnObservable: ((String) -> Void)? { get set }
    var player1IconObservable: ((UIImage) -> Void)? { get set }
    var player2IconObservable: ((UIImage) -> Void)? { get set }
    var playCountObservable: ((Int) -> Void)? { get set }
    var errorObservable: ((MainViewModel.Error) -> Void)? { get set }
    var selectedViewObservable: ((MainViewController.SelectedView?) -> Void)? { get set }
    var showGameStatusObservable: ((MainViewModel.GameStatus) -> Void)? { get set }
}

protocol MainViewModelOutputObserver {
    func bindViewModel(_ input: MainViewModelInput, output: inout MainViewModelOutput)
}

final class MainViewModel: MainViewModelOutput {
    typealias SelectedView = MainViewController.SelectedView
    
    enum GameState: Equatable {
        case tie
        var description: String {
            switch self {
            case .tie:
                return "No Winner"
            }
        }
    }
    
    enum GameStatus: Equatable {
        case ended(String)
        case reset
    }
    
    var playerTurnObservable: ((String) -> Void)?
    var player1IconObservable: ((UIImage) -> Void)?
    var player2IconObservable: ((UIImage) -> Void)?
    var errorObservable: ((Error) -> Void)?
    var playCountObservable: ((Int) -> Void)?
    var selectedViewObservable: ((SelectedView?) -> Void)?
    var showGameStatusObservable: ((GameStatus) -> Void)?
    
    private var playCount = 0 {
        didSet {
            output.playCountObservable?(playCount)
        }
    }
    
    enum Error: Swift.Error {
        case notValidLocation
        case noLocationSelected
        case badData
        case invalidPlayers
        case locationNotAvailable
        
        var localizedDescription: String {
            return String(describing: self)
        }
    }
    
    var output: MainViewModelOutput {
        return self
    }
    
    private let player1: Player
    private let player2: Player
    private var currentPlayer: Player {
        return playCount % 2 == 0 ? player1 : player2
    }
    
    init(player1: Player, player2: Player) throws {
        guard player1.mark != player2.mark,
            player1.turn != player2.turn else {
                throw Error.invalidPlayers
        }
        self.player1 = player1
        self.player2 = player2
    }
}

// MARK: - Private Methods
private extension MainViewModel {
    func isLocationValid(_ viewIdentifier: Int) throws {
        if viewIdentifier < Game.Constant.minimumLocationValue ||
            viewIdentifier > Game.Constant.maxLocationValue {
            throw Error.notValidLocation
        }
        
        if player1.moves.contains(viewIdentifier) || player2.moves.contains(viewIdentifier) {
            throw Error.locationNotAvailable
        }
    }
    
    func evaluateGame(player: Player) {
        if let winningString = Game.evaluate(player: player) {
            showGameStatusObservable?(GameStatus.ended(winningString))
        } else if playCount == Game.Constant.maxMoves {
            showGameStatusObservable?(GameStatus.ended(GameState.tie.description))
        }
    }
    
    func logPlay(selectedView: SelectedView) {
        updatePlayerMoves(viewIdentifier: selectedView.viewIdentifier)
        playCount += 1
        output.selectedViewObservable?(selectedView)
        output.playerTurnObservable?(currentPlayer.turn.string)
    }
    
    func reset() {
        output.player1IconObservable?(player1.image)
        output.player2IconObservable?(player2.image)
        playCount = 0
        output.playerTurnObservable?(currentPlayer.turn.string)
        player1.moves = []
        player2.moves = []
    }
    
    func updatePlayerMoves(viewIdentifier: Int) {
        currentPlayer.moves.append(viewIdentifier)
    }
}

// MARK: - MainViewModelInput
extension MainViewModel: MainViewModelInput {
    func viewDidLoad() {
        reset()
    }
    
    func tapped(viewIdentifier: Int) {
        do {
            try isLocationValid(viewIdentifier)
            let selectedView = SelectedView(viewIdentifier: viewIdentifier,
                                            image: currentPlayer.image,
                                            isSelected: true)
            let playerThatMove = currentPlayer
            logPlay(selectedView: selectedView)
            evaluateGame(player: playerThatMove)
            
        } catch let error as Error {
            output.errorObservable?(error)
        } catch {
            //TODO: Handle this error
        }
    }
    
    func tappedReset() {
        reset()
        output.showGameStatusObservable?(GameStatus.reset)
    }
}
