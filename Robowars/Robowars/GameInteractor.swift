//
//  GameInteractor.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public final class GameInteractor {
    private let gameEngine: GameEngine
    private var firstRobot: Robot?
    private var secondRobot: Robot?
    private var gameMode: GameMode?
    
    public var isReady: Bool {
        if firstRobot?.ships.isEmpty == false && secondRobot?.ships.isEmpty == false {
            return true
        }

        return false
    }
    
    public init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }
    
    public func start() {
        guard firstRobot != nil, secondRobot != nil, gameMode != nil else { return }
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
