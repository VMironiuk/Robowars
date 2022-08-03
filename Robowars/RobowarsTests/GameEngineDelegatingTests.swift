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
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotDidChangeThreeTimes() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setSecondRobot(DummyRobot())
        sut.setSecondRobot(DummyRobot())
        sut.setSecondRobot(DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotDidChangeCallCount, 3)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotHasIncorrectShipsPlacement() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 1)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
    }
    
    func test_gameEngineInformsItsDelegateTwiceWhenFirstRobotWithIncorrectShipsPlacementChangedTwice() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(BrokenRobot())
        sut.setFirstRobot(BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 2)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotHasIncorrectShipsPlacement() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setSecondRobot(BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 1)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
    }
    
    func test_gameEngineInformsItsDelegateTwiceWhenSecondRobotWithIncorrectShipsPlacementChangedTwice() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setSecondRobot(BrokenRobot())
        sut.setSecondRobot(BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 2)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
    }
    
    func test_gameEngineInformsItsDelegateTwiceWhenFirstAndSecondRobotsHaveIncorrectShipsPlacement() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(BrokenRobot())
        sut.setSecondRobot(BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 2)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
    }

    func test_gameEngineInformsItsDelegateFourTimesWhenFirstAndSecondRobotsWithIncorrectShipsPlacementChangedTwice() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(BrokenRobot())
        sut.setSecondRobot(BrokenRobot())
        sut.setFirstRobot(BrokenRobot())
        sut.setSecondRobot(BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 4)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[2])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[3])
    }
    
    func test_gameEngineInformsItsDelegateWithProperErrorDescriptionWhenFirstAndSecondRobotsHasIncorrectShipsPlacement() {
        // Given
        let sut = GameEngine(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let firstBrokenRobot = BrokenRobot(name: "FirstBrokenRobot")
        let secondBrokenRobot = BrokenRobot(name: "SecondBrokenRobot")
        let expectedFirstError = GameEngineError(robotName: firstBrokenRobot.name)
        let expectedSecondError = GameEngineError(robotName: secondBrokenRobot.name)
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.setFirstRobot(firstBrokenRobot)
        sut.setSecondRobot(secondBrokenRobot)
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.errors[.zero]!.localizedDescription, expectedFirstError.localizedDescription)
        XCTAssertEqual(gameEngineDelegateSpy.errors[1]!.localizedDescription, expectedSecondError.localizedDescription)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotDidShoot() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        sut.setFirstRobot(firstShootingRobot)
        sut.setSecondRobot(secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotShootsCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotDidShoot() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 1, height: 1)])
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        sut.setFirstRobot(firstShootingRobot)
        sut.setSecondRobot(secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotShootsCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWithProperShootResults() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 2, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 2, height: 1)])
        let expectedFirstRobotShootResults: [ShootResult] = [.miss, .hit, .kill]
        let expectedSecondRobotShootResults: [ShootResult] = [.miss]
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        sut.setFirstRobot(firstShootingRobot)
        sut.setSecondRobot(secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotShootResults, expectedFirstRobotShootResults)
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotShootResults, expectedSecondRobotShootResults)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotWon() {
        // Given
        let sut = GameEngine(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let gameEngineDelegateSpy = GameEngineDelegateSpy()
        sut.delegate = gameEngineDelegateSpy
        sut.setFirstRobot(firstShootingRobot)
        sut.setSecondRobot(secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.winner, .firstRobot)
    }

    // Helpers
    
    private enum Winner {
        case none, firstRobot, secondRobot
    }
    
    private class GameEngineDelegateSpy: GameEngineDelegate {
        private(set) var firstRobotDidChangeCallCount: Int = .zero
        private(set) var secondRobotDidChangeCallCount: Int = .zero
        private(set) var firstRobotShootResults: [ShootResult] = []
        private(set) var secondRobotShootResults: [ShootResult] = []
        private(set) var winner: Winner = .none
        private(set) var errors: [Error?] = []
        var didFailCallCount: Int {
            errors.count
        }
        var firstRobotShootsCount: Int {
            firstRobotShootResults.count
        }
        var secondRobotShootsCount: Int {
            secondRobotShootResults.count
        }
        
        func gameEngine(_ gameEngine: GameEngine, didChangeFirstRobotWithShips ships: [CGRect]) {
            firstRobotDidChangeCallCount += 1
        }
        
        func gameEngine(_ gameEngine: GameEngine, didChangeSecondRobotWithShips ships: [CGRect]) {
            secondRobotDidChangeCallCount += 1
        }
        
        func gameEngine(_ gameEngine: GameEngine, didFailWithError error: Error?) {
            errors.append(error)
        }
        
        func gameEngine(_ gameEngine: GameEngine, firstRobotDidShootWithResult result: ShootResult) {
            firstRobotShootResults.append(result)
        }
        
        func gameEngine(_ gameEngine: GameEngine, secondRobotDidShootWithResult result: ShootResult) {
            secondRobotShootResults.append(result)
        }
        
        func gameEngine(_ gameEngine: GameEngine, firstRobotDidWinWithMessage message: String) {
            winner = .firstRobot
        }
        
        func gameEngine(_ gameEngine: GameEngine, secondRobotDidWinWithMessage message: String) {
            winner = .secondRobot
        }
    }
    
    private class BrokenRobot: Robot {
        var ships: [CGRect] {
            []
        }
        let name: String
        let winnerMessage: String = ""
        
        init(name: String = "") {
            self.name = name
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {}
        func shoot() -> CGPoint { .zero }
        func shootResult(_ result: ShootResult, for coordinate: CGPoint) {}
    }
    
    private class ShootingRobot: Robot {
        private let shoots: [CGPoint] = [.zero, CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0)]
        private var currenntShoot: Int = .zero
        let ships: [CGRect]
        let name: String = ""
        let winnerMessage: String
        
        init(ships: [CGRect], winnerMessage: String = "") {
            self.ships = ships
            self.winnerMessage = winnerMessage
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {
        }
        
        func shoot() -> CGPoint {
            let shoot = shoots[currenntShoot]
            currenntShoot = (currenntShoot + 1) % shoots.count
            return shoot
        }
        
        func shootResult(_ result: ShootResult, for coordinate: CGPoint) {
        }
    }
}
