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
    
    func test_isReady_returnsTrueOnNonEmptyListsOfShips() {
        let sut = GameInteractor(gameEngine: DummyGameEngine())
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        sut.setGameMode(.classic)
        firstRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        secondRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        XCTAssertTrue(sut.isReady)
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
        robot.set(battlefield: .zero, ships: [])
        XCTAssertFalse(sut.isReady)
    }
    
    // MARK: - Helpers
    
    private class DummyGameEngine: GameEngine {
        func start() {}
    }
}
