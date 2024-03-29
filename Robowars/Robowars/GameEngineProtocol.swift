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
    func update(gameSpeed: GameSpeed)
}

public protocol GameEngineDelegate: AnyObject {
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeFirstRobot robot: RobotProtocol, withShips ships: [CGRect])
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeSecondRobot robot: RobotProtocol, withShips ships: [CGRect])
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobot robot: RobotProtocol, didShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobot robot: RobotProtocol, didShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobot robot: RobotProtocol, didWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobot robot: RobotProtocol, didWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobot robot: RobotProtocol, didLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobot robot: RobotProtocol, didLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize)
    func gameEngine(_ gameEngine: GameEngineProtocol, didFailWithError error: Error?)
}

public struct GameEngineFactory {
    private init() {}

    public static func defaultGameEngine(with gameMode: GameMode) -> GameEngineProtocol {
        GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: gameMode))
    }
}
