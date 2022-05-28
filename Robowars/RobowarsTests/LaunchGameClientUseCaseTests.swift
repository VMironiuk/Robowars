//
//  LaunchGameClientUseCaseTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import XCTest

protocol Robot {}

class DummyRobot: Robot {}

final class GameInteractor {
    var firstRobot: Robot?
    var secondRobot: Robot?
    var startCallCount: Int = .zero
    
    func start() {
        guard firstRobot != nil, secondRobot != nil else { return }
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
}
