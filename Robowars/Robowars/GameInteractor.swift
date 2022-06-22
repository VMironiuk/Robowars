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
    
    public var isReady: Bool {
        guard let firstRobot = firstRobot,
              let secondRobot = secondRobot,
              shipsValidator.isValid(ships: firstRobot.ships),
              shipsValidator.isValid(ships: secondRobot.ships) else {
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
}
