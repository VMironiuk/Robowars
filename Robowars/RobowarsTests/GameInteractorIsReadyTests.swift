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
        let sut = GameInteractor(gameEngine: DummyGameEngine())
        XCTAssertFalse(sut.isReady)
    }
    
    // MARK: - Helpers
    
    private class DummyGameEngine: GameEngine {
        func start() {}
    }
}
