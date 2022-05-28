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

final class GameInteractor {
    var firstRobot: Robot?
    var secondRobot: Robot?
    var gameMode: GameMode?
    var startCallCount: Int = .zero
    
    func start() {
        guard firstRobot != nil, secondRobot != nil, gameMode != nil else { return }
        startCallCount += 1
    }
}

class LaunchGameClientUseCaseTests: XCTestCase {
    
    func test_start_doesNotInvokesOnGameInteractorInit() {
        let sut = GameInteractor()
        XCTAssertEqual(sut.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereAreNoRobots() {
        let sut = GameInteractor()
        sut.start()
        XCTAssertEqual(sut.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereIsNoRobot() {
        let sut = GameInteractor()
        sut.firstRobot = DummyRobot()
        sut.start()
        XCTAssertEqual(sut.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokeIfThereIsNoGameMode() {
        let sut = GameInteractor()
        sut.firstRobot = DummyRobot()
        sut.secondRobot = DummyRobot()
        sut.start()
        XCTAssertEqual(sut.startCallCount, .zero)
    }
    
    func test_start_doesNotInvokesIfRobotsAndGameModeAreSet() {
        let sut = GameInteractor()
        sut.firstRobot = DummyRobot()
        sut.secondRobot = DummyRobot()
        sut.gameMode = GameMode.classic
        sut.start()
        XCTAssertEqual(sut.startCallCount, 1)
    }
}
