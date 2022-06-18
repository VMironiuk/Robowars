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
        // Given
        let sut = makeSUT()
        // When
        // Then
        XCTAssertFalse(sut.isReady)
    }
    
    func test_isReady_returnsTrueOnCorrectSetOfDependencies() {
        // Given
        let sut = makeSUT()
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        sut.setGameMode(.classic)
        firstRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        secondRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        // Then
        XCTAssertTrue(sut.isReady)
    }
    
    func test_isReady_returnsFalseOnDependenciesSetExceptGameMode() {
        // Given
        let sut = makeSUT()
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        firstRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        secondRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        // Then
        XCTAssertFalse(sut.isReady)
    }

    func test_isReady_returnsFalseOnDependenciesSetExceptOneRobotSet() {
        // Given
        let sut = makeSUT()
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        sut.setGameMode(.classic)
        firstRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        // Then
        XCTAssertFalse(sut.isReady)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> GameInteractor {
        GameInteractor(gameEngine: DummyGameEngine(), shipsValidator: DummyShipsValidator())
    }
    
    private class DummyGameEngine: GameEngine {
        func start() {}
    }
}
