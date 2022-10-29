//
//  MainViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 28.10.2022.
//

import XCTest
import Robowars
@testable import RobowarsClient_macOS

final class MainViewControllerTests: XCTestCase {

    func test_mainVC_init_doesNotSendMessagesToBattlefieldVCs() {
        let firstBattlefieldVC = BattlefieldViewControllerSpy()
        let secondBattlefieldVC = BattlefieldViewControllerSpy()
        _ = MainViewController(
            firstBattlefieldViewController: firstBattlefieldVC,
            secondBattlefieldViewController: secondBattlefieldVC
        )
        
        XCTAssertEqual(firstBattlefieldVC.updateBattlefieldCallCount, .zero)
        XCTAssertEqual(firstBattlefieldVC.updateShipsCallCount, .zero)
        XCTAssertEqual(firstBattlefieldVC.updateTileCallCount, .zero)

        XCTAssertEqual(secondBattlefieldVC.updateBattlefieldCallCount, .zero)
        XCTAssertEqual(secondBattlefieldVC.updateShipsCallCount, .zero)
        XCTAssertEqual(secondBattlefieldVC.updateTileCallCount, .zero)
    }
    
    func test_mainVC_sendsUpdateBattlefieldMessageOnGameEngineNewGameMode() {
        let firstBattlefieldVC = BattlefieldViewControllerSpy()
        let secondBattlefieldVC = BattlefieldViewControllerSpy()
        let sut = MainViewController(
            firstBattlefieldViewController: firstBattlefieldVC,
            secondBattlefieldViewController: secondBattlefieldVC
        )
        let gameEngine = GameEngineFactory.defaultGameEngine(with: .classic)
        gameEngine.delegate = sut
        
        gameEngine.update(firstRobot: DummyRobot())
        gameEngine.update(secondRobot: DummyRobot())
        gameEngine.update(gameMode: .flyweight)
        
        XCTAssertEqual(firstBattlefieldVC.updateBattlefieldCallCount, 1)
        XCTAssertEqual(firstBattlefieldVC.updateShipsCallCount, .zero)
        XCTAssertEqual(firstBattlefieldVC.updateTileCallCount, .zero)

        XCTAssertEqual(secondBattlefieldVC.updateBattlefieldCallCount, 1)
        XCTAssertEqual(secondBattlefieldVC.updateShipsCallCount, .zero)
        XCTAssertEqual(secondBattlefieldVC.updateTileCallCount, .zero)
    }
    
    // MARK: - Helpers
    
    private final class BattlefieldViewControllerSpy: BattlefieldViewControllerProtocol {
        private(set) var updateBattlefieldCallCount: Int = .zero
        private(set) var updateShipsCallCount: Int = .zero
        private(set) var updateTileCallCount: Int = .zero
        
        func updateBattlefield(_ newBattlefield: CGRect) {
            updateBattlefieldCallCount += 1
        }
        
        func updateShips(_ newShips: [CGRect]) {
            updateShipsCallCount += 1
        }
        
        func updateTile(for coordinate: CGPoint) {
            updateTileCallCount += 1
        }
    }
    
    private final class DummyRobot: RobotProtocol {
        var ships: [CGRect] {
            []
        }
        
        var name: String {
            ""
        }
        
        var winnerMessage: String {
            ""
        }
        
        var loserMessage: String {
            ""
        }
        
        func set(battlefield: CGRect, ships: [CGSize]) {
        }
        
        func shoot() -> CGPoint {
            .zero
        }
        
        func shootResult(_ result: ShootResult) {
        }
    }
}
