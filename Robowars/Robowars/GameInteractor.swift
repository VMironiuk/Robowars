//
//  GameInteractor.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public final class GameInteractor {
    private let gameEngine: GameEngine
    
    public var isReady: Bool {
        gameEngine.isValid
    }
    
    public init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }
    
    public func start() {
        guard isReady else { return }
        gameEngine.start()
    }
    
    public func setFirstRobot(_ newFirstRobot: Robot) {
        gameEngine.setFirstRobot(newFirstRobot)
    }
    
    public func setSecondRobot(_ newSecondRobot: Robot) {
        gameEngine.setSecondRobot(newSecondRobot)
    }
}
