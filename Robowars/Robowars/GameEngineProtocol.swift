//
//  GameEngineProtocol.swift
//  Robowars
//
//  Created by Volodymyr Myroniuk on 13.08.2022.
//

import Foundation

public enum GameSpeed: String {
    case slow = "Slow"
    case fast = "Fast"
    case blazinglyFast = "Blazingly Fast"
    
    var timeInterval: TimeInterval {
        switch self {
        case .slow: return 0.05
        case .fast: return 0.01
        case .blazinglyFast: return 0.0
        }
    }
}

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
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, firstRobotDidLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, secondRobotDidLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngineProtocol, didChangeGameModeWithBattleFieldSize battlefieldSize: CGSize)
    func gameEngine(_ gameEngine: GameEngineProtocol, didFailWithError error: Error?)
}

public struct GameEngineFactory {
    private init() {}

    public static func defaultGameEngine(with gameMode: GameMode) -> GameEngineProtocol {
        GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: gameMode))
    }
}
