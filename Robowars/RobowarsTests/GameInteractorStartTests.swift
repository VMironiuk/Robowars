//
//  GameInteractorStartTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import XCTest
import Robowars

class GameInteractorStartTests: XCTestCase {
    
    func test_start_doesNotInvokeOnGameInteractorInit() {
        // Given
        let (_, gameEngine) = makeSUT()
        // When
        // Then
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereAreNoRobots() {
        // Given
        let (sut, gameEngine) = makeSUT()
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereIsNoRobot() {
        // Given
        let (sut, gameEngine) = makeSUT()
        // When
        sut.setFirstRobot(DummyRobot())
        sut.start()
        // Then
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokesIfRobotsAndGameModeAreSet() {
        // Given
        let (sut, gameEngine) = makeSUT()
        let gameMode = GameMode.classic
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        firstRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        secondRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        sut.start()
        // Then
        XCTAssertEqual(gameEngine.startCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (GameInteractor, GameEngineSpy) {
        let gameEngine = GameEngineSpy(shipsValidator: DummyShipsValidator())
        let sut = GameInteractor(gameEngine: gameEngine)
        return (sut, gameEngine)
    }
        
    private class GameEngineSpy: GameEngine {
        private let shipsValidator: ShipsValidator
        private var firstRobot: Robot?
        private var secondRobot: Robot?
        private(set) var startCallCount = 0
        
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
        
        func start() {
            startCallCount += 1
        }
        
        func setFirstRobot(_ robot: Robot) {
            firstRobot = robot
        }
        
        func setSecondRobot(_ robot: Robot) {
            secondRobot = robot
        }
    }
}
