//
//  LaunchGameClientUseCaseTests.swift
//  RobowarsTests
//
//  Created by Vladimir Mironiuk on 28.05.2022.
//

import XCTest

final class GameInteractor {
    var startCallCount: Int = .zero
}

class LaunchGameClientUseCaseTests: XCTestCase {
    
    func test_start_doesNotInvokesOnGameInteractorInit() {
        let sut = GameInteractor()
        XCTAssertEqual(sut.startCallCount, .zero)
    }
}
