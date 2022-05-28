//
//  LaunchGameClientUseCaseTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import XCTest
import Robowars

enum GameMode {
    case classic
}

protocol GameEngine: AnyObject {
    func start()
}

final class GameInteractor {
    private let gameEngine: GameEngine
    private var firstRobot: Robot?
    private var secondRobot: Robot?
    private var gameMode: GameMode?
    
    init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }
    
    func start() {
        guard firstRobot != nil, secondRobot != nil, gameMode != nil else { return }
        gameEngine.start()
    }
    
    func setFirstRobot(_ newFirstRobot: Robot) {
        firstRobot = newFirstRobot
    }
    
    func setSecondRobot(_ newSecondRobot: Robot) {
        secondRobot = newSecondRobot
    }
    
    func setGameMode(_ newGameMode: GameMode) {
        gameMode = newGameMode
    }
}

class LaunchGameClientUseCaseTests: XCTestCase {
    
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
        sut.setFirstRobot(DummyRobot())
        sut.setSecondRobot(DummyRobot())
        sut.setGameMode(.classic)
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
    
    private class DummyRobot: Robot {}
    
    private class GameEngineSpy: GameEngine {
        private(set) var startCallCount = 0
        
        func start() {
            startCallCount += 1
        }
    }
}
