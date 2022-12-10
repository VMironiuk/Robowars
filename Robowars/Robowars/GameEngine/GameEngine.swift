//
//  GameEngine.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

final class GameEngine: GameEngineProtocol {
    private let shipsValidator: ShipsValidatorProtocol
    private var firstRobot: RobotProtocol?
    private var secondRobot: RobotProtocol?
    private var firstRobotShipsPoints: [[CGPoint]] = []
    private var secondRobotShipsPoints: [[CGPoint]] = []
    private var shootingTimer: Timer?
    private var shootingRobot: RobotProtocol?

    var gameSpeed: GameSpeed = .blazinglyFast
    weak var delegate: GameEngineDelegate?

    var isValid: Bool {
        guard let firstRobot = firstRobot,
              let secondRobot = secondRobot,
              shipsValidator.isValid(ships: firstRobot.ships),
              shipsValidator.isValid(ships: secondRobot.ships) else {
            return false
        }
        
        return true
    }
    
    init(shipsValidator: ShipsValidatorProtocol) {
        self.shipsValidator = shipsValidator
    }
    
    func start() {
        guard isValid, let firstRobot = firstRobot else {
            return { delegate?.gameEngine(self, didFailWithError: GameEngineError.invalidConstruction) }()
        }
        shootingRobot = firstRobot
        if gameSpeed == .blazinglyFast {
            loopShooting()
        } else {
            var timeInterval: Double
            switch gameSpeed {
            case .fast:
                timeInterval = 0.01
            case .slow:
                timeInterval = 0.05
            default:
                fatalError("Cannot handle enum case")
            }
            shootingTimer = Timer.scheduledTimer(
                timeInterval: timeInterval,
                target: self,
                selector: #selector(nextShoot),
                userInfo: nil,
                repeats: true
            )
        }
    }
        
    func update(firstRobot robot: RobotProtocol) {
        firstRobot = robot
        delegate?.gameEngine(self, didChangeFirstRobot: robot, withShips: robot.ships)
        firstRobotShipsPoints = shipsPoints(from: robot.ships)
        if !shipsValidator.isValid(ships: robot.ships) {
            delegate?.gameEngine(self, didFailWithError: GameEngineError.invalidFirstRobotShipsArrangement)
        }
    }
    
    func update(secondRobot robot: RobotProtocol) {
        secondRobot = robot
        delegate?.gameEngine(self, didChangeSecondRobot: robot, withShips: robot.ships)
        secondRobotShipsPoints = shipsPoints(from: robot.ships)
        if !shipsValidator.isValid(ships: robot.ships) {
            delegate?.gameEngine(self, didFailWithError: GameEngineError.invalidSecondRobotShipsArrangement)
        }
    }
    
    func update(gameMode: GameMode) {
        shipsValidator.update(gameMode: gameMode)
        delegate?.gameEngine(self, didChangeGameModeWithBattleFieldSize: gameMode.battlefieldSize)
        
        guard let firstRobot = firstRobot, let secondRobot = secondRobot else {
            fatalError("Robot cannot be nil")
        }
        
        firstRobot.set(battlefieldSize: gameMode.battlefieldSize, shipSizes: gameMode.shipSizes)
        secondRobot.set(battlefieldSize: gameMode.battlefieldSize, shipSizes: gameMode.shipSizes)
        
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
        var result: ShootResult = .miss(shootPoint)
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
                    return .kill(shootPoint)
                }
                else {
                    return .hit(shootPoint)
                }
            }
        }
        return .miss(shootPoint)
    }
    
    private func processShooting()  {
        guard let shootingRobot = shootingRobot else { fatalError("Shooting robot is invalid") }
        let shootPoint = shootingRobot.shoot()
        let shootResult = shootResult(for: shootPoint, to: oppositeRobot(to: shootingRobot))
        if firstRobotShipsPoints.isEmpty {
            delegate?.gameEngine(self, secondRobotDidWinWithMessage: shootingRobot.winnerMessage)
            delegate?.gameEngine(self, firstRobotDidLoseWithMessage: oppositeRobot(to: shootingRobot).loserMessage)
            shootingTimer?.invalidate()
            self.shootingRobot = nil
            return
        }
        if secondRobotShipsPoints.isEmpty {
            delegate?.gameEngine(self, firstRobotDidWinWithMessage: shootingRobot.winnerMessage)
            delegate?.gameEngine(self, secondRobotDidLoseWithMessage: oppositeRobot(to: shootingRobot).loserMessage)
            shootingTimer?.invalidate()
            self.shootingRobot = nil
            return
        }
        shootingRobot.shootResult(shootResult)
        if case .miss = shootResult {
            self.shootingRobot = oppositeRobot(to: shootingRobot)
        }
    }
    
    private func loopShooting() {
        while shootingRobot != nil {
            processShooting()
        }
    }

    @objc private func nextShoot() {
        processShooting()
    }
}
