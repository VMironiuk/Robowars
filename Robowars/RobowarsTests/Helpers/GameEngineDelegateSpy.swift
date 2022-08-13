//
//  GameEngineDelegateSpy.swift
//  RobowarsTests
//
//  Created by Volodymyr Myroniuk on 13.08.2022.
//

import Foundation
import Robowars

enum Winner {
    case none, firstRobot, secondRobot
}

enum Loser {
    case none, firstRobot, secondRobot
}

class GameEngineDelegateSpy: GameEngineDelegate {
    private(set) var firstRobotDidChangeCallCount: Int = .zero
    private(set) var secondRobotDidChangeCallCount: Int = .zero
    private(set) var gameModeDidChangeCallCount: Int = .zero
    private(set) var firstRobotShootResults: [ShootResult] = []
    private(set) var secondRobotShootResults: [ShootResult] = []
    private(set) var winner: Winner = .none
    private(set) var loser: Loser = .none
    private(set) var winnerMessage: String = ""
    private(set) var loserMessage: String = ""
    private(set) var errors: [Error?] = []
    var didFailCallCount: Int {
        errors.count
    }
    var firstRobotShootsCount: Int {
        firstRobotShootResults.count
    }
    var secondRobotShootsCount: Int {
        secondRobotShootResults.count
    }
    
    func gameEngine(_ gameEngine: GameEngine, didChangeFirstRobotWithShips ships: [CGRect]) {
        firstRobotDidChangeCallCount += 1
    }
    
    func gameEngine(_ gameEngine: GameEngine, didChangeSecondRobotWithShips ships: [CGRect]) {
        secondRobotDidChangeCallCount += 1
    }
    
    func gameEngine(_ gameEngine: GameEngine, didFailWithError error: Error?) {
        errors.append(error)
    }
    
    func gameEngine(_ gameEngine: GameEngine, firstRobotDidShootWithResult result: ShootResult) {
        firstRobotShootResults.append(result)
    }
    
    func gameEngine(_ gameEngine: GameEngine, secondRobotDidShootWithResult result: ShootResult) {
        secondRobotShootResults.append(result)
    }
    
    func gameEngine(_ gameEngine: GameEngine, firstRobotDidWinWithMessage message: String) {
        winner = .firstRobot
        winnerMessage = message
    }
    
    func gameEngine(_ gameEngine: GameEngine, secondRobotDidWinWithMessage message: String) {
        winner = .secondRobot
        winnerMessage = message
    }
    
    func gameEngine(_ gameEngine: GameEngine, firstRobotDidLoseWithMessage message: String) {
        loser = .firstRobot
        loserMessage = message
    }
    
    func gameEngine(_ gameEngine: GameEngine, secondRobotDidLoseWithMessage message: String) {
        loser = .secondRobot
        loserMessage = message
    }
    
    func gameEngine(_ gameEngine: GameEngine, didChangeGameModeWithBattleField battlefield: CGRect) {
        gameModeDidChangeCallCount += 1
    }
}