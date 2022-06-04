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
        // When
        let firstRobot = DummyRobot()
        let secondRobot = DummyRobot()
        sut.setFirstRobot(firstRobot)
        sut.setSecondRobot(secondRobot)
        sut.setGameMode(.classic)
        firstRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        secondRobot.set(battlefield: CGSize(width: 1, height: 1), ships: [CGSize(width: 1, height: 1)])
        sut.start()
        // Then
        XCTAssertEqual(gameEngine.startCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (GameInteractor, GameEngineSpy) {
        let gameEngine = GameEngineSpy()
        let sut = GameInteractor(gameEngine: gameEngine)
        return (sut, gameEngine)
    }
        
    private class GameEngineSpy: GameEngine {
        private(set) var startCallCount = 0
        
        func start() {
            startCallCount += 1
        }
    }
}
