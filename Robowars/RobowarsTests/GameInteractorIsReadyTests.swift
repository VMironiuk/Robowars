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
    
    private func makeSUT() -> (GameInteractor, GameMode) {
        let gameMode: GameMode = .classic
        let sut =  GameInteractor(
            gameEngine: DummyGameEngine(
                shipsValidator: ShipsArrangementValidator(
                    gameMode: gameMode
                )
            )
        )
        return (sut, gameMode)
    }
    
    private class DummyGameEngine: GameEngine {
        private let shipsValidator: ShipsValidator
        private var firstRobot: Robot?
        private var secondRobot: Robot?
        
        var isValid: Bool {
            guard let firstRobot = firstRobot,
                  let secondRobot = secondRobot,
                  shipsValidator.isValid(ships: firstRobot.ships),
                  shipsValidator.isValid(ships: secondRobot.ships) else {
                return false
            }
            
            return true
        }
        
        init(shipsValidator: ShipsValidator) {
            self.shipsValidator = shipsValidator
        }
        
        func start() {}
        
        func setFirstRobot(_ robot: Robot) {
            firstRobot = robot
        }
        
        func setSecondRobot(_ robot: Robot) {
            secondRobot = robot
        }
    }
}
