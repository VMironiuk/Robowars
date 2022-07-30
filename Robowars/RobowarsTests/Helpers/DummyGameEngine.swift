//
//  DummyGameEngine.swift
//  RobowarsTests
//
//  Created by Volodymyr Myroniuk on 13.07.2022.
//

import Foundation
import Robowars

class DummyGameEngine: GameEngineProtocol {
    private let gameEngine: GameEngine
    var delegate: GameEngineDelegate?
    var winner: Robot?
    
    var isValid: Bool {
        gameEngine.isValid
    }
    
    init(shipsValidator: ShipsValidator) {
        self.gameEngine = GameEngine(shipsValidator: shipsValidator)
    }
    
    func start() {}
    
    func setFirstRobot(_ robot: Robot) {
        gameEngine.setFirstRobot(robot)
    }
    
    func setSecondRobot(_ robot: Robot) {
        gameEngine.setSecondRobot(robot)
    }
}
