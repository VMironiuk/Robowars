//
//  RandomatorShipsProvider.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 30.01.2023.
//

import Foundation
import Robowars

struct RandomatorShipsProvider {
    static func makeShips(for gameMode: GameMode) -> [CGRect] {
        switch gameMode {
        case .classic:
            return classicGameModeShips()
        case .flyweight:
            return flyweightGameModeShips()
        case .middleweight:
            return middleweightGameModeShips()
        case .heavyweight:
            return heavyweightGameModeShips()
        case .superHeavyweight:
            return superHeavyweightGameModeShips()
        }
    }
    
    private static func classicGameModeShips() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 1, height: 4),
            CGRect(x: 0, y: 5, width: 1, height: 3),
            CGRect(x: 0, y: 9, width: 2, height: 1),
            CGRect(x: 2, y: 0, width: 3, height: 1),
            CGRect(x: 6, y: 0, width: 2, height: 1),
            CGRect(x: 9, y: 4, width: 1, height: 1),
            CGRect(x: 3, y: 6, width: 1, height: 1),
            CGRect(x: 7, y: 7, width: 1, height: 1),
            CGRect(x: 3, y: 9, width: 2, height: 1),
            CGRect(x: 4, y: 3, width: 1, height: 1)
        ]
    }
    
    private static func flyweightGameModeShips() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 1, height: 1),
            CGRect(x: 2, y: 2, width: 1, height: 1),
            CGRect(x: 4, y: 4, width: 1, height: 1),
            CGRect(x: 6, y: 6, width: 1, height: 1),
            CGRect(x: 8, y: 8, width: 1, height: 1),
            CGRect(x: 0, y: 9, width: 1, height: 1),
            CGRect(x: 2, y: 7, width: 1, height: 1),
            CGRect(x: 9, y: 0, width: 1, height: 1),
            CGRect(x: 7, y: 2, width: 1, height: 1),
            CGRect(x: 5, y: 2, width: 1, height: 1)
        ]
    }
    
    private static func middleweightGameModeShips() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 3, height: 2),
            CGRect(x: 5, y: 4, width: 3, height: 2),
            CGRect(x: 4, y: 0, width: 3, height: 2),
            CGRect(x: 0, y: 6, width: 2, height: 3),
            CGRect(x: 3, y: 7, width: 2, height: 3),
            CGRect(x: 8, y: 0, width: 2, height: 3)
        ]
    }
    
    private static func heavyweightGameModeShips() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 4, height: 3),
            CGRect(x: 17, y: 0, width: 3, height: 4),
            CGRect(x: 13, y: 1, width: 3, height: 4),
            CGRect(x: 16, y: 10, width: 4, height: 3),
            CGRect(x: 15, y: 15, width: 3, height: 4),
            CGRect(x: 11, y: 8, width: 3, height: 4),
            CGRect(x: 2, y: 6, width: 3, height: 4),
            CGRect(x: 7, y: 13, width: 4, height: 3),
            CGRect(x: 1, y: 16, width: 3, height: 4),
            CGRect(x: 6, y: 3, width: 4, height: 3)
        ]
    }
    
    private static func superHeavyweightGameModeShips() -> [CGRect] {
        [
            CGRect(x: 1, y: 1, width: 5, height: 6),
            CGRect(x: 3, y: 10, width: 6, height: 5),
            CGRect(x: 9, y: 0, width: 5, height: 6),
            CGRect(x: 2, y: 16, width: 5, height: 6),
            CGRect(x: 4, y: 24, width: 6, height: 5),
            CGRect(x: 12, y: 8, width: 5, height: 6),
            CGRect(x: 9, y: 18, width: 6, height: 5),
            CGRect(x: 20, y: 24, width: 5, height: 6),
            CGRect(x: 22, y: 2, width: 6, height: 5),
            CGRect(x: 23, y: 13, width: 5, height: 6)
        ]
    }
}
