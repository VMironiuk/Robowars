//
//  GameEngineProtocol.swift
//  Robowars
//
//  Created by Volodymyr Myroniuk on 13.08.2022.
//

import Foundation

public protocol GameEngineProtocol: AnyObject {
    var isValid: Bool { get }
    var delegate: GameEngineDelegate? { get set }
    
    func start()
    func update(firstRobot robot: RobotProtocol)
    func update(secondRobot robot: RobotProtocol)
    func update(gameMode: GameMode)
}

public protocol GameEngineDelegate: AnyObject {
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeFirstRobot: RobotProtocol, withShips ships: [CGRect])
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeSecondRobot: RobotProtocol, withShips ships: [CGRect])
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleField battlefield: CGRect)
    func gameEngine(_ gameEngine: GameEngineProtocol, didFailWithError error: Error?)
}

public struct GameEngineFactory {
    private init() {}

    public static func defaultGameEngine(with gameMode: GameMode) -> GameEngineProtocol {
        GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: gameMode))
    }
}
