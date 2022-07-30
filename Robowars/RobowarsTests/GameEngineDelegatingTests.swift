//
//  GameEngineDelegatingTests.swift
//  RobowarsTests
//
//  Created by Volodymyr Myroniuk on 30.07.2022.
//

import XCTest
import Robowars

class GameEngineDelegatingTests: XCTestCase {
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotDidChange() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotDidChangeCallCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotDidChangeThreeTimes() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(DummyRobot())
        sut.setFirstRobot(DummyRobot())
        sut.setFirstRobot(DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotDidChangeCallCount, 3)
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotDidChange() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setSecondRobot(DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotDidChangeCallCount, 1)
    }
    
    // Helpers
    
    private class GameEngineDelegateSpy: GameEngineDelegate {
        private(set) var firstRobotDidChangeCallCount: Int = .zero
        private(set) var secondRobotDidChangeCallCount: Int = .zero
        
        func gameEngine(_ gameEngine: GameEngine, didChangeFirstRobotWithShips ships: [CGRect]) {
            firstRobotDidChangeCallCount += 1
        }
        
        func gameEngine(_ gameEngine: GameEngine, didChangeSecondRobotWithShips ships: [CGRect]) {
            secondRobotDidChangeCallCount += 1
        }
    }
}
