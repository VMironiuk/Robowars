//
//  GameEngineGameLoopTests.swift
//  RobowarsTests
//
//  Created by Volodymyr Myroniuk on 16.07.2022.
//

import XCTest
import Robowars

class GameEngineGameLoopTests: XCTestCase {
    
    func test_gameEngine_gameLoopFinishedWithFirstRobotAsWinner() {
        // Given
        let firstRobot = ShootingTestRobot(ships: [CGRect(x: 1, y: 1, width: 1, height: 1)], maxBattlefieldSize: 2)
        let secondRobot = ShootingTestRobot(ships: [CGRect(x: 1, y: 1, width: 1, height: 1)], maxBattlefieldSize: 2)
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        // When
        sut.start()
        // Then
        XCTAssertTrue(sut.winner === firstRobot)
    }
    
    func test_gameEngine_gameLoopFinishedWithSecondRobotAsWinner() {
        // Given
        let firstRobot = ShootingTestRobot(ships: [CGRect(x: 2, y: 0, width: 1, height: 1)], maxBattlefieldSize: 2)
        let secondRobot = ShootingTestRobot(ships: [CGRect(x: 1, y: 1, width: 1, height: 1)], maxBattlefieldSize: 2)
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        // When
        sut.start()
        // Then
        XCTAssertTrue(sut.winner === secondRobot)
    }
    
    func test_gameEngine_gameLoopForMoreRealisticGameFinishedWithFirstRobotAsWinner() {
        // Given
        let firstRobot = ShootingTestRobot(ships: makeShipsInGoodWay(), maxBattlefieldSize: 10)
        let secondRobot = ShootingTestRobot(ships: makeShipsInGoodWay(), maxBattlefieldSize: 10)
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        // When
        sut.start()
        // Then
        XCTAssertTrue(sut.winner === firstRobot)
    }
    
    func test_gameEngine_gameLoopForMoreRealisticGameFinishedWithSecondRobotAsWinner() {
        // Given
        let firstRobot = ShootingTestRobot(ships: makeShipsInBadWay(), maxBattlefieldSize: 10)
        let secondRobot = ShootingTestRobot(ships: makeShipsInGoodWay(), maxBattlefieldSize: 10)
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        // When
        sut.start()
        // Then
        XCTAssertTrue(sut.winner === secondRobot)
    }

    // Helpers
    
    private final class ShootingTestRobot: Robot {
        private var shootPoint: CGPoint = .zero
        private let maxBattlefieldSize: CGFloat
        private let _ships: [CGRect]
        
        init(ships: [CGRect], maxBattlefieldSize: CGFloat) {
            self._ships = ships
            self.maxBattlefieldSize = maxBattlefieldSize
        }
        
        var ships: [CGRect] {
            _ships
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {
            // Can be empty for these tests
        }
        
        func shoot() -> CGPoint {
            let nextShootPoint = shootPoint
            
            shootPoint.x = (shootPoint.x + 1).truncatingRemainder(dividingBy: maxBattlefieldSize + 1)
            if nextShootPoint.x == maxBattlefieldSize {
                shootPoint.y = (shootPoint.y + 1).truncatingRemainder(dividingBy: maxBattlefieldSize + 1)
            }
            
            return nextShootPoint
        }
        
        func shootResult(_ result: ShootResult, for coordinate: CGPoint) {
            // Can be empty for these tests
        }
    }
    
    private func makeShipsInGoodWay() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 1, height: 4),
            CGRect(x: 0, y: 5, width: 1, height: 3),
            CGRect(x: 0, y: 9, width: 3, height: 1),
            CGRect(x: 2, y: 0, width: 2, height: 1),
            CGRect(x: 5, y: 0, width: 2, height: 1),
            CGRect(x: 4, y: 9, width: 2, height: 1),
            CGRect(x: 2, y: 2, width: 1, height: 1),
            CGRect(x: 2, y: 4, width: 1, height: 1),
            CGRect(x: 2, y: 7, width: 1, height: 1),
            CGRect(x: 7, y: 5, width: 1, height: 1),
        ]
    }
    
    private func makeShipsInBadWay() -> [CGRect] {
        [
            CGRect(x: 0, y: 0, width: 4, height: 1),
            CGRect(x: 5, y: 0, width: 3, height: 1),
            CGRect(x: 9, y: 0, width: 1, height: 1),
            CGRect(x: 0, y: 2, width: 3, height: 1),
            CGRect(x: 4, y: 2, width: 2, height: 1),
            CGRect(x: 7, y: 2, width: 2, height: 1),
            CGRect(x: 0, y: 4, width: 2, height: 1),
            CGRect(x: 3, y: 4, width: 1, height: 1),
            CGRect(x: 5, y: 4, width: 1, height: 1),
            CGRect(x: 7, y: 4, width: 1, height: 1),
        ]
    }
}
