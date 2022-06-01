//
//  GameInteractorIsReadyTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 01.06.2022.
//

import XCTest
import Robowars

class GameInteractorIsReadyTests: XCTestCase {

    func test_isReady_returnsFalseOnInit() {
        let sut = GameInteractor(gameEngine: DummyGameEngine())
        XCTAssertFalse(sut.isReady)
    }
    
    func test_isReady_returnsFalseOnRobotSet() {
        let sut = GameInteractor(gameEngine: DummyGameEngine())
        sut.setFirstRobot(DummyRobot())
        XCTAssertFalse(sut.isReady)
    }
    
    func test_isReady_returnsFalseOnEmptyListOfRobots() {
        let sut = GameInteractor(gameEngine: DummyGameEngine())
        let robot = DummyRobot()
        sut.setFirstRobot(robot)
        let _ = robot.set(battlefield: .zero, ships: [])
        XCTAssertFalse(sut.isReady)
    }
    
    // MARK: - Helpers
    
    private class DummyGameEngine: GameEngine {
        func start() {}
    }
    
    private class DummyRobot: Robot {
        func set(battlefield: CGSize, ships: [CGSize]) -> [CGRect] {
            []
        }
    }
}
