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
        let (sut, _) = makeSUT()
        // When
        // Then
        XCTAssertFalse(sut.isReady)
    }
    
    func test_isReady_returnsTrueOnCorrectSetOfDependencies() {
        // Given
        let (sut, gameMode) = makeSUT()
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        firstRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        secondRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        // Then
        XCTAssertTrue(sut.isReady)
    }

    func test_isReady_returnsFalseOnDependenciesSetExceptOneRobotSet() {
        // Given
        let (sut, gameMode) = makeSUT()
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        firstRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        // Then
        XCTAssertFalse(sut.isReady)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (GameInteractor, GameMode) {
        let gameMode: GameMode = .classic
        let shipsValidator = ShipsArrangementValidator(gameMode: gameMode)
        let gameEngine = DummyGameEngine(shipsValidator: shipsValidator)
        let sut =  GameInteractor(gameEngine: gameEngine)
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(shipsValidator, file: file, line: line)
        trackForMemoryLeak(gameEngine, file: file, line: line)
        return (sut, gameMode)
    }
}
