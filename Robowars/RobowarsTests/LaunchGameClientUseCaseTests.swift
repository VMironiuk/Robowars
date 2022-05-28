//
//  LaunchGameClientUseCaseTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import XCTest

protocol Robot {}

class DummyRobot: Robot {}

enum GameMode {
    case classic
}

protocol GameEngine: AnyObject {
    func start()
}

final class GameInteractor {
    let gameEngine: GameEngine
    
    var firstRobot: Robot?
    var secondRobot: Robot?
    var gameMode: GameMode?
    var startCallCount: Int = .zero
    
    init(gameEngine: GameEngine) {
        self.gameEngine = gameEngine
    }
    
    func start() {
        guard firstRobot != nil, secondRobot != nil, gameMode != nil else { return }
        gameEngine.start()
    }
}

class LaunchGameClientUseCaseTests: XCTestCase {
    
    func test_start_doesNotInvokeOnGameInteractorInit() {
        let (_, gameEngine) = makeSUT()
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereAreNoRobots() {
        let (sut, gameEngine) = makeSUT()
        sut.start()
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereIsNoRobot() {
        let (sut, gameEngine) = makeSUT()
        sut.firstRobot = DummyRobot()
        sut.start()
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereIsNoGameMode() {
        let (sut, gameEngine) = makeSUT()
        sut.firstRobot = DummyRobot()
        sut.secondRobot = DummyRobot()
        sut.start()
        XCTAssertEqual(gameEngine.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokesIfRobotsAndGameModeAreSet() {
        let (sut, gameEngine) = makeSUT()
        sut.firstRobot = DummyRobot()
        sut.secondRobot = DummyRobot()
        sut.gameMode = GameMode.classic
        sut.start()
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
