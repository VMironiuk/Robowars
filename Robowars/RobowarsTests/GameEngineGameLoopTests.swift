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
        let firstRobot = ShootingTestRobot(ship: CGRect(x: 1, y: 1, width: 1, height: 1), maxBattlefieldSize: 2)
        let secondRobot = ShootingTestRobot(ship: CGRect(x: 1, y: 1, width: 1, height: 1), maxBattlefieldSize: 2)
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
        let firstRobot = ShootingTestRobot(ship: CGRect(x: 2, y: 0, width: 1, height: 1), maxBattlefieldSize: 2)
        let secondRobot = ShootingTestRobot(ship: CGRect(x: 1, y: 1, width: 1, height: 1), maxBattlefieldSize: 2)
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
        private let ship: CGRect
        
        init(ship: CGRect, maxBattlefieldSize: CGFloat) {
            self.ship = ship
            self.maxBattlefieldSize = maxBattlefieldSize
        }
        
        var ships: [CGRect] {
            [ship]
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
}
