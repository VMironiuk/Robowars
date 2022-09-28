//
//  GameEngine.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public final class GameEngine: GameEngineProtocol {
    private let shipsValidator: ShipsValidatorProtocol
    private var firstRobot: RobotProtocol?
    private var secondRobot: RobotProtocol?
    private var firstRobotShipsPoints: [[CGPoint]] = []
    private var secondRobotShipsPoints: [[CGPoint]] = []
    public weak var delegate: GameEngineDelegate?

    public var isValid: Bool {
        guard let firstRobot = firstRobot,
              let secondRobot = secondRobot,
              shipsValidator.isValid(ships: firstRobot.ships),
              shipsValidator.isValid(ships: secondRobot.ships) else {
            return false
        }
        
        return true
    }
    
    public init(shipsValidator: ShipsValidatorProtocol) {
        self.shipsValidator = shipsValidator
    }
    
    public func start() {
        guard isValid, let firstRobot = firstRobot else {
            return { delegate?.gameEngine(self, didFailWithError: GameEngineError.invalidConstruction) }()
        }
        var shootingRobot = firstRobot
        while true {
            let shootPoint = shootingRobot.shoot()
            let shootResult = shootResult(for: shootPoint, to: oppositeRobot(to: shootingRobot))
            if firstRobotShipsPoints.isEmpty {
                delegate?.gameEngine(self, secondRobotDidWinWithMessage: shootingRobot.winnerMessage)
                delegate?.gameEngine(self, firstRobotDidLoseWithMessage: oppositeRobot(to: shootingRobot).loserMessage)
                return
            }
            if secondRobotShipsPoints.isEmpty {
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
        
    public func update(firstRobot robot: RobotProtocol) {
        firstRobot = robot
        delegate?.gameEngine(self, didChangeFirstRobotWithShips: robot.ships)
        firstRobotShipsPoints = shipsPoints(from: robot.ships)
        if !shipsValidator.isValid(ships: robot.ships) {
            delegate?.gameEngine(self, didFailWithError: GameEngineError.invalidFirstRobotShipsArrangement)
        }
    }
    
    public func update(secondRobot robot: RobotProtocol) {
        secondRobot = robot
        delegate?.gameEngine(self, didChangeSecondRobotWithShips: robot.ships)
        secondRobotShipsPoints = shipsPoints(from: robot.ships)
        if !shipsValidator.isValid(ships: robot.ships) {
            delegate?.gameEngine(self, didFailWithError: GameEngineError.invalidSecondRobotShipsArrangement)
        }
    }
    
    public func update(gameMode: GameMode) {
        shipsValidator.update(gameMode: gameMode)
        delegate?.gameEngine(self, didChangeGameModeWithBattleField: gameMode.battlefield())
        
        guard let firstRobot = firstRobot, let secondRobot = secondRobot else {
            fatalError("Robot cannot be nil")
        }
        update(firstRobot: firstRobot)
        update(secondRobot: secondRobot)
    }
    
    private func oppositeRobot(to robot: RobotProtocol) -> RobotProtocol {
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
    
    private func shootResult(for shootPoint: CGPoint, to robot: RobotProtocol) -> ShootResult {
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
