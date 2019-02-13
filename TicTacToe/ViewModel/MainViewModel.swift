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
    func tapped(isSelected: Bool, viewIdentifier: Int)
    func tappedReset()
}

protocol MainViewModelOutput: class {
    var playerTurnObservable: ((String) -> Void)? { get set }
    var player1IconObservable: ((UIImage) -> Void)? { get set }
    var player2IconObservable: ((UIImage) -> Void)? { get set }
    var playCountObservable: ((Int) -> Void)? { get set }
    var errorObservable: ((MainViewModel.Error) -> Void)? { get set }
    var selectedViewObservable: ((MainViewModel.SelectedView?) -> Void)? { get set }
    var showGameStateObservable: ((MainViewModel.Game.State) -> Void)? { get set }
}

protocol MainViewModelOutputObserver {
    func bindViewModel(_ input: MainViewModelInput, output: inout MainViewModelOutput)
}

final class MainViewModel: MainViewModelOutput {
    var playerTurnObservable: ((String) -> Void)?
    var player1IconObservable: ((UIImage) -> Void)?
    var player2IconObservable: ((UIImage) -> Void)?
    var errorObservable: ((Error) -> Void)?
    var playCountObservable: ((Int) -> Void)?
    var selectedViewObservable: ((SelectedView?) -> Void)?
    var showGameStateObservable: ((Game.State) -> Void)?
    
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
    
    struct SelectedView {
        let viewIdentifier: Int
        let image: UIImage?
        let isSelected: Bool
    }
    
    struct Game {
        enum Constant {
            static let minimumLocationValue: Location = 0
            static let maxLocationValue: Location = 15
            static let maxMoves = 16
        }
        
        enum State: Equatable {
            case winner(WinningCombination, Player)
            case tie
            case reset
        }
        
        enum WinningCombination: Equatable {
            case topDiagonal
            
            var locations: Locations {
                switch self {
                case .topDiagonal: return [0, 5, 10, 15]
                }
            }
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
        
        if player1.locations.contains(viewIdentifier) || player2.locations.contains(viewIdentifier) {
            throw Error.locationNotAvailable
        }
    }
    
    func evaluateGame() {
        if let winnerCombination = hasWinningCombination(.topDiagonal, player: player1) {
            showGameStateObservable?(winnerCombination)
        } else if playCount == Game.Constant.maxMoves {
            showGameStateObservable?(Game.State.tie)
        }
    }
    
    func hasWinningCombination(_ combination: Game.WinningCombination, player: Player) -> Game.State? {
        for value in combination.locations where !player.locations.contains(value) {
            return nil
        }
        return Game.State.winner(.topDiagonal, player)
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
        player1.locations = []
        player2.locations = []
    }
    
    func updatePlayerMoves(viewIdentifier: Int) {
        currentPlayer.locations.append(viewIdentifier)
    }
}

// MARK: - MainViewModelInput
extension MainViewModel: MainViewModelInput {
    func viewDidLoad() {
        reset()
    }
    
    func tapped(isSelected: Bool, viewIdentifier: Int) {
        do {
            try isLocationValid(viewIdentifier)
            let selectedView = SelectedView(viewIdentifier: viewIdentifier,
                                            image: currentPlayer.image,
                                            isSelected: true)
            logPlay(selectedView: selectedView)
            evaluateGame()
            
        } catch let error as Error {
            output.errorObservable?(error)
        } catch {
            //TODO: Handle this error
        }
    }
    
    func tappedReset() {
        reset()
        output.showGameStateObservable?(Game.State.reset)
    }
}
