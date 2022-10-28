//
//  MainViewControllerTests.swift
//  RobowarsClient-macOSTests
//
//  Created by Volodymyr Myroniuk on 28.10.2022.
//

import XCTest

protocol BattlefieldViewControllerProtocol {
    func updateBattlefield(_ newBattlefield: CGRect)
    func updateShips(_ newShips: [CGRect])
    func updateTile(for coordinate: CGPoint)
}

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

final class MainViewController {
    
    init(
        firstBattlefieldViewController: BattlefieldViewControllerProtocol,
        secondBattlefieldViewController: BattlefieldViewControllerProtocol
    ) {
        
    }
}

final class MainViewControllerTests: XCTestCase {

    func test_mainVC_init_doesNotSendMessagesToBattlefieldVCs() {
        let firstBattlefieldVC = BattlefieldViewControllerSpy()
        let secondBattlefieldVC = BattlefieldViewControllerSpy()
        let sut = MainViewController(
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
}
