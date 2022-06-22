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
    
    func test_start_doesNotInvokeIfThereIsNoGameMode() {
        // Given
        let (sut, gameEngine) = makeSUT()
        // When
        sut.setFirstRobot(DummyRobot())
        sut.setSecondRobot(DummyRobot())
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
        sut.setGameMode(gameMode)
        firstRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        secondRobot.set(battlefield: gameMode.battlefield(), ships: gameMode.ships())
        sut.start()
        // Then
        XCTAssertEqual(gameEngine.startCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (GameInteractor, GameEngineSpy) {
        let gameEngine = GameEngineSpy()
        let sut = GameInteractor(gameEngine: gameEngine, shipsValidator: DummyShipsValidator())
        return (sut, gameEngine)
    }
        
    private class GameEngineSpy: GameEngine {
        private(set) var startCallCount = 0
        
        func start() {
            startCallCount += 1
        }
    }
}
