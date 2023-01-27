//
//  Randomator.swift
//  RobowarsClient-macOS
//
//  Created by Volodymyr Myroniuk on 25.01.2023.
//

import Foundation
import Robowars

class Randomator: RobotProtocol {
    private let model: String
    
    private var battlefieldSize: CGSize = .zero
    
    private(set) var ships: [CGRect] = []
    
    var name: String {
        "Randomator \(model)"
    }
    
    var winnerMessage: String {
        "TODO: add a winner message"
    }
    
    var loserMessage: String {
        "TODO: add a loser message"
    }
    
    init(model: String) {
        self.model = model
    }
    
    func update(for gameMode: GameMode) {
        self.battlefieldSize = gameMode.battlefieldSize
        updateShips(for: gameMode)
    }
    
    func shoot() -> CGPoint {
        // TODO: add implementation
        .zero
    }
    
    func shootResult(_ result: ShootResult) {
        // TODO: add implementation
    }
    
    private func updateShips(for gameMode: GameMode) {
        ships = makeShips(for: gameMode)
    }
    
    private func makeShips(for gameMode: GameMode) -> [CGRect] {
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
    
    private func classicGameModeShips() -> [CGRect] {
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
    
    private func flyweightGameModeShips() -> [CGRect] {
        // TODO: add implementation
        []
    }
    
    private func middleweightGameModeShips() -> [CGRect] {
        // TODO: add implementation
        []
    }
    
    private func heavyweightGameModeShips() -> [CGRect] {
        // TODO: add implementation
        []
    }
    
    private func superHeavyweightGameModeShips() -> [CGRect] {
        // TODO: add implementation
        []
    }
}
