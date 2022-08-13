//
//  GameEngine.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public struct GameEngineError: Error {
    private let robotName: String

    public init(robotName: String) {
        self.robotName = robotName
    }
}

extension GameEngineError: LocalizedError {
    public var errorDescription: String? {
        "\(robotName) has incorrect ships placement"
    }
}

public struct GameEngineGeneralError: Error {
    public init() {}
}

extension GameEngineGeneralError: LocalizedError {
    public var errorDescription: String? {
        "Game engine did not constructed completely"
    }
}

public protocol GameEngineProtocol: AnyObject {
    var isValid: Bool { get }
    var winner: Robot? { get }
    var delegate: GameEngineDelegate? { get set }
    
    func start()
    func setFirstRobot(_ robot: Robot)
    func setSecondRobot(_ robot: Robot)
    func update(gameMode: GameMode)
}

public protocol GameEngineDelegate: AnyObject {
    func gameEngine(_ gameEngine: GameEngine, didChangeFirstRobotWithShips ships: [CGRect])
    func gameEngine(_ gameEngine: GameEngine, didChangeSecondRobotWithShips ships: [CGRect])
    func gameEngine(_ gameEngine: GameEngine, firstRobotDidShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngine, secondRobotDidShootWithResult result: ShootResult)
    func gameEngine(_ gameEngine: GameEngine, firstRobotDidWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngine, secondRobotDidWinWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngine, firstRobotDidLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngine, secondRobotDidLoseWithMessage message: String)
    func gameEngine(_ gameEngine: GameEngine, didChangeGameModeWithBattleField battlefield: CGRect)
    func gameEngine(_ gameEngine: GameEngine, didFailWithError error: Error?)
}

public final class GameEngine: GameEngineProtocol {
    private let shipsValidator: ShipsValidator
    private var firstRobot: Robot?
    private var secondRobot: Robot?
    private var firstRobotShipsPoints: [[CGPoint]] = []
    private var secondRobotShipsPoints: [[CGPoint]] = []
    public weak var delegate: GameEngineDelegate?
    public var winner: Robot?
    
    public var isValid: Bool {
        guard let firstRobot = firstRobot,
              let secondRobot = secondRobot,
              shipsValidator.isValid(ships: firstRobot.ships),
              shipsValidator.isValid(ships: secondRobot.ships) else {
            return false
        }
        
        return true
    }
    
    public init(shipsValidator: ShipsValidator) {
        self.shipsValidator = shipsValidator
    }
    
    public func start() {
        guard isValid, let firstRobot = firstRobot else {
            return { delegate?.gameEngine(self, didFailWithError: GameEngineGeneralError()) }()
        }
        var shootingRobot = firstRobot
        while true {
            let shootPoint = shootingRobot.shoot()
            let shootResult = shootResult(for: shootPoint, to: oppositeRobot(to: shootingRobot))
            if firstRobotShipsPoints.isEmpty {
                winner = shootingRobot
                delegate?.gameEngine(self, secondRobotDidWinWithMessage: shootingRobot.winnerMessage)
                delegate?.gameEngine(self, firstRobotDidLoseWithMessage: oppositeRobot(to: shootingRobot).loserMessage)
                return
            }
            if secondRobotShipsPoints.isEmpty {
                winner = shootingRobot
                delegate?.gameEngine(self, firstRobotDidWinWithMessage: shootingRobot.winnerMessage)
                delegate?.gameEngine(self, secondRobotDidLoseWithMessage: oppositeRobot(to: shootingRobot).loserMessage)
                return
            }
            shootingRobot.shootResult(shootResult, for: shootPoint)
            if case .miss = shootResult {
                shootingRobot = oppositeRobot(to: shootingRobot)
            }
        }
    }
        
    public func setFirstRobot(_ robot: Robot) {
        firstRobot = robot
        delegate?.gameEngine(self, didChangeFirstRobotWithShips: robot.ships)
        firstRobotShipsPoints = shipsPoints(from: robot.ships)
        if !shipsValidator.isValid(ships: robot.ships) {
            delegate?.gameEngine(self, didFailWithError: GameEngineError(robotName: robot.name))
        }
    }
    
    public func setSecondRobot(_ robot: Robot) {
        secondRobot = robot
        delegate?.gameEngine(self, didChangeSecondRobotWithShips: robot.ships)
        secondRobotShipsPoints = shipsPoints(from: robot.ships)
        if !shipsValidator.isValid(ships: robot.ships) {
            delegate?.gameEngine(self, didFailWithError: GameEngineError(robotName: robot.name))
        }
    }
    
    public func update(gameMode: GameMode) {
        shipsValidator.update(gameMode: gameMode)
        delegate?.gameEngine(self, didChangeGameModeWithBattleField: gameMode.battlefield())
        
        guard let firstRobot = firstRobot, let secondRobot = secondRobot else {
            fatalError("Robot cannot be nil")
        }
        setFirstRobot(firstRobot)
        setSecondRobot(secondRobot)
    }
    
    private func oppositeRobot(to robot: Robot) -> Robot {
        guard let firstRobot = firstRobot, let secondRobot = secondRobot else {
            fatalError("Robot cannot be nil")
        }
        return robot === firstRobot ? secondRobot : firstRobot
    }

    private func shipsPoints(from ships: [CGRect]) -> [[CGPoint]] {
        var shipsPoints: [[CGPoint]] = []
        for ship in ships {
            var shipPoints: [CGPoint] = []
            for x in .zero..<Int(ship.width) {
                for y in .zero..<Int(ship.height) {
                    shipPoints.append(CGPoint(x: Int(ship.minX) + x, y: Int(ship.minY) + y))
                }
            }
            shipsPoints.append(shipPoints)
        }
        return shipsPoints
    }
    
    private func shootResult(for shootPoint: CGPoint, to robot: Robot) -> ShootResult {
        var result: ShootResult = .miss
        if robot === firstRobot {
            result = shootResult(for: shootPoint, with: &firstRobotShipsPoints)
            delegate?.gameEngine(self, secondRobotDidShootWithResult: result)
        }
        else {
            result = shootResult(for: shootPoint, with: &secondRobotShipsPoints)
            delegate?.gameEngine(self, firstRobotDidShootWithResult: result)
        }
        return result
    }
    
    private func shootResult(
        for shootPoint: CGPoint,
        with shipsPoints: inout [[CGPoint]]
    ) -> ShootResult {
        for shipIndex in .zero..<shipsPoints.count {
            let currentShipPoints = shipsPoints[shipIndex]
            if let shootPointIndex = currentShipPoints.firstIndex(of: shootPoint) {
                shipsPoints[shipIndex].remove(at: shootPointIndex)
                if shipsPoints[shipIndex].isEmpty {
                    shipsPoints.remove(at: shipIndex)
                    return .kill
                }
                else {
                    return .hit
                }
            }
        }
        return .miss
    }
}
