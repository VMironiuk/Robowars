//
//  GameInteractor.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public final class GameInteractor {
    private let gameEngine: GameEngine
    private let shipsValidator: ShipsValidator
    private var firstRobot: Robot?
    private var secondRobot: Robot?
    private var gameMode: GameMode?
    
    public var isReady: Bool {
        guard gameMode != .none,
              firstRobot != nil,
              secondRobot != nil,
              firstRobot?.ships.isEmpty == false,
              secondRobot?.ships.isEmpty == false else {
            return false
        }

        return true
    }
    
    public init(gameEngine: GameEngine, shipsValidator: ShipsValidator) {
        self.gameEngine = gameEngine
        self.shipsValidator = shipsValidator
    }
    
    public func start() {
        guard isReady else { return }
        gameEngine.start()
    }
    
    public func setFirstRobot(_ newFirstRobot: Robot) {
        firstRobot = newFirstRobot
    }
    
    public func setSecondRobot(_ newSecondRobot: Robot) {
        secondRobot = newSecondRobot
    }
    
    public func setGameMode(_ newGameMode: GameMode) {
        gameMode = newGameMode
    }
}
