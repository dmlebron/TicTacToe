//
//  Player.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

typealias Location = Int
typealias Locations = [Int]

// MARK: - Mark
enum Mark {
    case x
    case o
    
    var image: UIImage? {
        switch self {
        case .o: return UIImage.o
        case .x: return UIImage.x
        }
    }
}

// MARK: - PlayerModel
final class Player {
    enum Turn {
        case firstPlayer
        case secondPlayer
        
        var string: String {
            switch self {
            case .firstPlayer: return "First Player Turn"
            case .secondPlayer: return "Second Player Turn"
            }
        }
    }
    
    let mark: Mark
    var locations: Locations = []
    let turn: Turn
    
    init(mark: Mark, turn: Turn) {
        self.mark = mark
        self.turn = turn
    }
    
    var image: UIImage {
        return mark.image!
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        guard lhs.mark == rhs.mark, lhs.locations == rhs.locations else { return false }
        return true
    }
}
