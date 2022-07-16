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
        let firstRobot = ShootingTestRobot(ship: CGRect(x: 1, y: 1, width: 1, height: 1))
        let secondRobot = ShootingTestRobot(ship: CGRect(x: 1, y: 1, width: 1, height: 1))
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        // When
        sut.start()
        // Then
        XCTAssertTrue(sut.winner === firstRobot)
    }
    
    // Helpers
    
    private final class ShootingTestRobot: Robot {
        private var shootPoint: CGPoint = .zero
        private let maxShootPointValue: CGFloat = 2
        private let ship: CGRect
        
        init(ship: CGRect) {
            self.ship = ship
        }
        
        var ships: [CGRect] {
            [ship]
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {
            // Can be empty. For these tests 3x3 battlefiled with a single 1x1 ship are used
        }
        
        func shoot() -> CGPoint {
            let nextShootPoint = shootPoint
            
            shootPoint.x += (shootPoint.x + 1).truncatingRemainder(dividingBy: maxShootPointValue + 1)
            if nextShootPoint.x == maxShootPointValue {
                shootPoint.y += (shootPoint.y + 1).truncatingRemainder(dividingBy: maxShootPointValue + 1)
            }
            
            return nextShootPoint
        }
        
        func shootResult(_ result: ShootResult, for coordinate: CGPoint) {
            // Can be empty for these tests
        }
    }
}
