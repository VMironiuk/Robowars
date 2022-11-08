//
//  GameEngineDelegatingTests.swift
//  RobowarsTests
//
//  Created by Volodymyr Myroniuk on 30.07.2022.
//

import XCTest
@testable import Robowars

class GameEngineDelegatingTests: XCTestCase {
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotDidChange() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotDidChangeCallCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotDidChangeThreeTimes() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: DummyRobot())
        sut.update(firstRobot: DummyRobot())
        sut.update(firstRobot: DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotDidChangeCallCount, 3)
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotDidChange() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(secondRobot: DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotDidChangeCallCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotDidChangeThreeTimes() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(secondRobot: DummyRobot())
        sut.update(secondRobot: DummyRobot())
        sut.update(secondRobot: DummyRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotDidChangeCallCount, 3)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotHasIncorrectShipsPlacement() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 1)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
    }
    
    func test_gameEngineInformsItsDelegateTwiceWhenFirstRobotWithIncorrectShipsPlacementChangedTwice() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: BrokenRobot())
        sut.update(firstRobot: BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 2)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotHasIncorrectShipsPlacement() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(secondRobot: BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 1)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
    }
    
    func test_gameEngineInformsItsDelegateTwiceWhenSecondRobotWithIncorrectShipsPlacementChangedTwice() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(secondRobot: BrokenRobot())
        sut.update(secondRobot: BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 2)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
    }
    
    func test_gameEngineInformsItsDelegateTwiceWhenFirstAndSecondRobotsHaveIncorrectShipsPlacement() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: BrokenRobot())
        sut.update(secondRobot: BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 2)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
    }

    func test_gameEngineInformsItsDelegateFourTimesWhenFirstAndSecondRobotsWithIncorrectShipsPlacementChangedTwice() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: BrokenRobot())
        sut.update(secondRobot: BrokenRobot())
        sut.update(firstRobot: BrokenRobot())
        sut.update(secondRobot: BrokenRobot())
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.didFailCallCount, 4)
        XCTAssertNotNil(gameEngineDelegateSpy.errors[.zero])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[1])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[2])
        XCTAssertNotNil(gameEngineDelegateSpy.errors[3])
    }
    
    func test_gameEngineInformsItsDelegateWithProperErrorDescriptionWhenFirstAndSecondRobotsHasIncorrectShipsPlacement() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: ShipsArrangementValidator(gameMode: .classic))
        let firstBrokenRobot = BrokenRobot(name: "FirstBrokenRobot")
        let secondBrokenRobot = BrokenRobot(name: "SecondBrokenRobot")
        let expectedFirstError: GameEngineError = .invalidFirstRobotShipsArrangement
        let expectedSecondError: GameEngineError = .invalidSecondRobotShipsArrangement
        sut.delegate = gameEngineDelegateSpy
        // When
        sut.update(firstRobot: firstBrokenRobot)
        sut.update(secondRobot: secondBrokenRobot)
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.errors[.zero]!.localizedDescription, expectedFirstError.localizedDescription)
        XCTAssertEqual(gameEngineDelegateSpy.errors[1]!.localizedDescription, expectedSecondError.localizedDescription)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotDidShoot() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotShootsCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotDidShoot() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 1, height: 1)])
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotShootsCount, 1)
    }
    
    func test_gameEngineInformsItsDelegateWithProperShootResults() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 2, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 2, height: 1)])
        let expectedFirstRobotShootResults: [ShootResult] = [
            .miss(CGPoint(x: 0, y: 0)), .hit(CGPoint(x: 1, y: 0)), .kill(CGPoint(x: 2, y: 0))
        ]
        let expectedSecondRobotShootResults: [ShootResult] = [.miss(CGPoint(x: 0, y: 0))]
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotShootResults, expectedFirstRobotShootResults)
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotShootResults, expectedSecondRobotShootResults)
    }
    
    func test_gameEngineInformsItsDelegateWhenFirstRobotWon() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)], winnerMessage: "first won")
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.winner, .firstRobot)
        XCTAssertEqual(gameEngineDelegateSpy.winnerMessage, firstShootingRobot.winnerMessage)
    }
    
    func test_gameEngineInformsItsDelegateWhenSecondRobotWon() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 1, height: 1)], winnerMessage: "second won")
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.winner, .secondRobot)
        XCTAssertEqual(gameEngineDelegateSpy.winnerMessage, secondShootingRobot.winnerMessage)
    }

    func test_gameEngineInformsItsDelegateWhenFirstDidLose() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)], loserMessage: "first lost")
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 1, y: 0, width: 1, height: 1)])
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.loser, .firstRobot)
        XCTAssertEqual(gameEngineDelegateSpy.loserMessage, firstShootingRobot.loserMessage)
    }

    func test_gameEngineInformsItsDelegateWhenSecondRobotDidLose() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)], loserMessage: "second lost")
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.start()
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.loser, .secondRobot)
        XCTAssertEqual(gameEngineDelegateSpy.loserMessage, secondShootingRobot.loserMessage)
    }

    func test_gameEngineInformsItsDelegateWhenGameModeDidChange() {
        // Given
        let (sut, gameEngineDelegateSpy) = makeSUT(shipsValidator: DummyShipsValidator())
        let firstShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        let secondShootingRobot = ShootingRobot(ships: [CGRect(x: 0, y: 0, width: 1, height: 1)])
        sut.delegate = gameEngineDelegateSpy
        sut.update(firstRobot: firstShootingRobot)
        sut.update(secondRobot: secondShootingRobot)
        // When
        sut.update(gameMode: .classic)
        // Then
        XCTAssertEqual(gameEngineDelegateSpy.gameModeDidChangeCallCount, 1)
        XCTAssertEqual(gameEngineDelegateSpy.firstRobotDidChangeCallCount, 2)
        XCTAssertEqual(gameEngineDelegateSpy.secondRobotDidChangeCallCount, 2)
    }
    
    // Helpers
    
    private func makeSUT(
        shipsValidator: ShipsValidatorProtocol,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (GameEngineProtocol, GameEngineDelegateSpy) {
        let sut = GameEngine(shipsValidator: shipsValidator)
        let delegate = GameEngineDelegateSpy()
        trackForMemoryLeak(sut, file: file, line: line)
        trackForMemoryLeak(delegate, file: file, line: line)
        return (sut, delegate)
    }

    private class BrokenRobot: RobotProtocol {
        var ships: [CGRect] {
            []
        }
        let name: String
        let winnerMessage: String = ""
        let loserMessage: String = ""
        
        init(name: String = "") {
            self.name = name
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {}
        func shoot() -> CGPoint { .zero }
        func shootResult(_ result: ShootResult) {}
    }
    
    private class ShootingRobot: RobotProtocol {
        private let shoots: [CGPoint] = [.zero, CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0)]
        private var currentShoot: Int = .zero
        let ships: [CGRect]
        let name: String = ""
        let winnerMessage: String
        let loserMessage: String
        
        init(ships: [CGRect], winnerMessage: String = "", loserMessage: String = "") {
            self.ships = ships
            self.winnerMessage = winnerMessage
            self.loserMessage = loserMessage
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {
        }
        
        func shoot() -> CGPoint {
            let shoot = shoots[currentShoot]
            currentShoot = (currentShoot + 1) % shoots.count
            return shoot
        }
        
        func shootResult(_ result: ShootResult) {
        }
    }
}
