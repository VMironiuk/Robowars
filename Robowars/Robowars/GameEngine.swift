//
//  GameEngine.swift
//  Robowars
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import Foundation

public protocol GameEngineProtocol: AnyObject {
    var isValid: Bool { get }
    var winner: Robot? { get }
    
    func start()
    func setFirstRobot(_ robot: Robot)
    func setSecondRobot(_ robot: Robot)
}

public final class GameEngine: GameEngineProtocol {
    private let shipsValidator: ShipsValidator
    private var firstRobot: Robot?
    private var secondRobot: Robot?
    private var firstRobotShipsPoints: [[CGPoint]] = []
    private var secondRobotShipsPoints: [[CGPoint]] = []
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
        guard isValid, let firstRobot = firstRobot else { return }
        var shootingRobot = firstRobot
        while true {
            let shootPoint = shootingRobot.shoot()
            let shootResult = shootResult(for: shootPoint, to: oppositeRobot(to: shootingRobot))
            if firstRobotShipsPoints.isEmpty || secondRobotShipsPoints.isEmpty {
                winner = shootingRobot
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
        firstRobotShipsPoints = shipsPoints(from: robot.ships)
    }
    
    public func setSecondRobot(_ robot: Robot) {
        secondRobot = robot
        secondRobotShipsPoints = shipsPoints(from: robot.ships)
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
        if robot === firstRobot {
            return shootResult(for: shootPoint, with: &firstRobotShipsPoints)
        }
        return shootResult(for: shootPoint, with: &secondRobotShipsPoints)
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
