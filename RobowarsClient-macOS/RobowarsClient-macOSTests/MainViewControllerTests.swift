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
        // Given
        let firstBattlefieldVC = BattlefieldViewControllerSpy()
        let secondBattlefieldVC = BattlefieldViewControllerSpy()
        _ = MainViewController(
            firstBattlefieldViewController: firstBattlefieldVC,
            secondBattlefieldViewController: secondBattlefieldVC
        )
        
        // When
        
        // Then
        XCTAssertEqual(firstBattlefieldVC.updateBattlefieldSizeCallCount, .zero)
        XCTAssertEqual(firstBattlefieldVC.updateShipsCallCount, .zero)
        XCTAssertEqual(firstBattlefieldVC.updateTileCallCount, .zero)

        XCTAssertEqual(secondBattlefieldVC.updateBattlefieldSizeCallCount, .zero)
        XCTAssertEqual(secondBattlefieldVC.updateShipsCallCount, .zero)
        XCTAssertEqual(secondBattlefieldVC.updateTileCallCount, .zero)
    }
    
    func test_mainVC_sendsUpdateBattlefieldAndUpdateShipsMessagesOnGameEngineNewGameMode() {
        // Given
        let firstBattlefieldVC = BattlefieldViewControllerSpy()
        let secondBattlefieldVC = BattlefieldViewControllerSpy()
        let sut = MainViewController(
            firstBattlefieldViewController: firstBattlefieldVC,
            secondBattlefieldViewController: secondBattlefieldVC
        )
        _ = sut.view
        
        let gameEngine = GameEngineFactory.defaultGameEngine(with: .classic)
        gameEngine.delegate = sut
        
        // When
        gameEngine.update(firstRobot: DummyRobot())
        gameEngine.update(secondRobot: DummyRobot())
        gameEngine.update(gameMode: .flyweight)
        
        // Then
        XCTAssertEqual(firstBattlefieldVC.updateBattlefieldSizeCallCount, 1)
        XCTAssertEqual(firstBattlefieldVC.updateShipsCallCount, 2)
        XCTAssertEqual(firstBattlefieldVC.updateTileCallCount, .zero)

        XCTAssertEqual(secondBattlefieldVC.updateBattlefieldSizeCallCount, 1)
        XCTAssertEqual(secondBattlefieldVC.updateShipsCallCount, 2)
        XCTAssertEqual(secondBattlefieldVC.updateTileCallCount, .zero)
    }
    
    func test_mainVC_sendsUpdateTileMessagesOnRobotsShooting() {
        // Given
        let gameMode: GameMode = .classic
        let firstBattlefieldVC = BattlefieldViewControllerSpy()
        let secondBattlefieldVC = BattlefieldViewControllerSpy()
        let sut = MainViewController(
            firstBattlefieldViewController: firstBattlefieldVC,
            secondBattlefieldViewController: secondBattlefieldVC
        )
        _ = sut.view
        
        let gameEngine = GameEngineFactory.defaultGameEngine(with: gameMode)
        gameEngine.delegate = sut
        
        gameEngine.update(firstRobot: DummyRobot(gameMode: gameMode))
        gameEngine.update(secondRobot: DummyRobot(gameMode: gameMode))
        gameEngine.update(gameMode: gameMode)
        
        // When
        gameEngine.start()
        
        // Then
        XCTAssertEqual(firstBattlefieldVC.updateBattlefieldSizeCallCount, 1)
        XCTAssertEqual(firstBattlefieldVC.updateShipsCallCount, 2)
        XCTAssertEqual(firstBattlefieldVC.updateTileCallCount, 105)

        XCTAssertEqual(secondBattlefieldVC.updateBattlefieldSizeCallCount, 1)
        XCTAssertEqual(secondBattlefieldVC.updateShipsCallCount, 2)
        XCTAssertEqual(secondBattlefieldVC.updateTileCallCount, 103)
    }
    
    // MARK: - Helpers
    
    private final class BattlefieldViewControllerSpy: NSViewController, BattlefieldViewControllerProtocol {
        private(set) var updateBattlefieldSizeCallCount: Int = .zero
        private(set) var updateShipsCallCount: Int = .zero
        private(set) var updateTileCallCount: Int = .zero
        
        init() {
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            view = NSView(frame: .zero)
        }
        
        func updateBattlefieldSize(_ newBattlefieldSize: CGSize) {
            updateBattlefieldSizeCallCount += 1
        }
        
        func updateShips(_ newShips: [CGRect]) {
            updateShipsCallCount += 1
        }
        
        func updateTile(with state: TileState) {
            updateTileCallCount += 1
        }
    }
    
    private final class DummyRobot: RobotProtocol {
        private var shootPoint: CGPoint = .zero
        private let maxBattlefieldSize: CGFloat
        
        init(gameMode: GameMode = .classic) {
            guard gameMode == .classic else {
                fatalError("Game Mode is not supported in these tests")
            }
            
            maxBattlefieldSize = gameMode.battlefieldSize.width
        }

        var ships: [CGRect] {
            [
                CGRect(x: 0, y: 0, width: 1, height: 4),
                CGRect(x: 0, y: 5, width: 1, height: 3),
                CGRect(x: 0, y: 9, width: 3, height: 1),
                CGRect(x: 2, y: 0, width: 2, height: 1),
                CGRect(x: 5, y: 0, width: 2, height: 1),
                CGRect(x: 4, y: 9, width: 2, height: 1),
                CGRect(x: 2, y: 2, width: 1, height: 1),
                CGRect(x: 2, y: 4, width: 1, height: 1),
                CGRect(x: 2, y: 7, width: 1, height: 1),
                CGRect(x: 7, y: 5, width: 1, height: 1),
            ]
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
        
        func set(battlefieldSize: CGSize, ships: [CGSize]) {
        }
        
        func shoot() -> CGPoint {
            let nextShootPoint = shootPoint
            
            shootPoint.x = (shootPoint.x + 1).truncatingRemainder(dividingBy: maxBattlefieldSize + 1)
            if nextShootPoint.x == maxBattlefieldSize {
                shootPoint.y = (shootPoint.y + 1).truncatingRemainder(dividingBy: maxBattlefieldSize + 1)
            }
            
            return nextShootPoint
        }
        
        func shootResult(_ result: ShootResult) {
        }
    }
}
